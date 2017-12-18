import Stream
import Network

extension Response {
    public init(from bytes: [UInt8]) throws {
        let stream = BufferedInputStream(baseStream: InputByteStream(bytes))
        try self.init(from: stream)
    }

    @_specialize(exported: true, where T == NetworkStream)
    public init<T: InputStream>(from stream: BufferedInputStream<T>) throws {
        do {
            let version = try stream.read(until: .whitespace)
            self.version = try Version(from: version)
            try stream.consume(count: 1)

            let status = try stream.read(until: .cr)
            self.status = try Status(from: status)

            @inline(__always)
            func readLineEnd() throws {
                let lineEnd = try stream.read(count: 2)
                guard lineEnd.elementsEqual(Constants.lineEnd) else {
                    throw HTTPError.invalidRequest
                }
            }

            try readLineEnd()

            while true {
                let nameSlice = try stream.read { $0 != .colon && $0 != .lf }
                // "\r\n" found
                guard nameSlice.first != .cr else {
                    try stream.consume(count: 1)
                    break
                }
                let name = try HeaderName(from: nameSlice)

                try stream.consume(count: 1)

                let value = (try stream.read(until: .cr))
                    .trimmingLeftSpace().trimmingRightSpace()

                try readLineEnd()

                switch name {
                case .connection:
                    self.connection = try Connection(from: value)
                case .contentEncoding:
                    self.contentEncoding = try [ContentEncoding](from: value)
                case .contentLength:
                    self.contentLength = Int(from: value)
                case .contentType:
                    self.contentType = try ContentType(from: value)
                case .transferEncoding:
                    self.transferEncoding = try [TransferEncoding](from: value)
                case .setCookie:
                    self.setCookie.append(try SetCookie(from: value))
                default:
                    headers[name] = String(validating: value, as: .text)
                }
            }

            // Body

            // 1. content-lenght
            if let length = self.contentLength {
                guard length > 0 else {
                    self.rawBody = nil
                    return
                }
                self.rawBody = [UInt8](try stream.read(count: length))
                return
            }

            // 2. chunked
            guard let transferEncoding = self.transferEncoding,
                transferEncoding.contains(.chunked) else {
                    return
            }

            var body = [UInt8]()

            while true {
                let sizeBytes = try stream.read(until: .cr)
                try readLineEnd()

                // TODO: optimize using hex table
                guard let size = Int(from: sizeBytes, radix: 16) else {
                    throw HTTPError.invalidRequest
                }
                guard size > 0 else {
                    break
                }

                body.append(contentsOf: try stream.read(count: size))
                try readLineEnd()
            }

            self.rawBody = body

            if stream.count >= 2,
                stream.peek(count: 2)!.elementsEqual(Constants.lineEnd) {
                try stream.consume(count: 2)
            }
        } catch let error as BufferedInputStream<T>.Error
            where error == .insufficientData {
                throw HTTPError.unexpectedEnd
        }
    }
}
