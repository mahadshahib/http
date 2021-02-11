import JSON
import Stream

public enum Body {
    case none
    case bytes([UInt8])
    case input(StreamReader)
    case output((StreamWriter) throws -> Void)
}

extension Body: Equatable {
    public static func == (lhs: Body, rhs: Body) -> Bool {
        switch (lhs, rhs) {
        case (.none, .none): return true
        case let (.bytes(lhs), .bytes(rhs)): return lhs == rhs
        default: return false
        }
    }
}

public protocol BodyInpuStream: AnyObject {
    var body: Body { get set }
    var contentLength: Int? { get set }
    var transferEncoding: [TransferEncoding]? { get set }
    var inputStream: StreamReader? { get }
}

extension BodyInpuStream {
    public var inputStream: StreamReader? {
        get {
            guard case .input(let reader) = body else {
                return nil
            }
            return reader
        }
        set {
            switch newValue {
            case .none: self.body = .none
            case .some(let reader): self.body = .input(reader)
            }
        }
    }

    public var outputStream: ((StreamWriter) throws -> Void)? {
        get {
            guard case .output(let writer) = body else {
                return nil
            }
            return writer
        }
        set {
            switch newValue {
            case .none: self.body = .none
            case .some(let writer): self.body = .output(writer)
            }
        }
    }
}

extension BodyInpuStream {
    public var json: JSON.Value? {
        get {
            guard let bytes = bytes else {
                return nil
            }
            var value: JSON.Value? = nil
            // FIXME: [Concurrency]
            runAsyncAndBlock {
                let stream = InputByteStream(bytes)
                value = try? await JSON.Value.decode(from: stream)
            }
            return value
        }
        set {

            switch newValue {
            case .none:
                self.bytes = nil
            case .some(let json):
                let stream = OutputByteStream()
                // FIXME: [Concurrency]
                runAsyncAndBlock {
                    try? await json.encode(to: stream)
                }
                self.bytes = stream.bytes
            }
        }
    }

    public var string: String? {
        get {
            guard let bytes = bytes else {
                return nil
            }
            return String(bytes: bytes, encoding: .utf8)
        }
        set {
            switch newValue {
            case .none: self.bytes = nil
            case .some(let string): self.bytes = [UInt8](string.utf8)
            }
        }
    }

    public var bytes: [UInt8]? {
        get {
            switch body {
            case .bytes(let bytes): return bytes
            case .input(_):
                // FIXME: [Concurrency]
                var bytes: [UInt8]? = nil
                runAsyncAndBlock {
                    bytes = try? await self.readBytes()
                }
                return bytes
            default: return nil
            }
        }
        set {
            switch newValue {
            case .none:
                self.body = .none
                self.contentLength = nil
            case .some(let bytes):
                self.body = .bytes(bytes)
                self.contentLength = bytes.count
            }
        }
    }

    func readBytes() async throws -> [UInt8] {
        guard let reader = self.inputStream else {
            throw ParseError.invalidRequest
        }
        do {
            let bytes: [UInt8]
            if let contentLength = self.contentLength {
                bytes = try await reader.read(count: contentLength) { bytes in
                    guard bytes.count > 0 else {
                        self.body = .none
                        throw ParseError.invalidRequest
                    }
                    return [UInt8](bytes)
                }
            } else if self.transferEncoding?.contains(.chunked) == true  {
                let reader = ChunkedStreamReader(baseStream: reader)
                bytes = try await reader.readUntilEnd()
            } else {
                throw ParseError.invalidRequest
            }
            // cache
            self.body = .bytes(bytes)
            return bytes
        } catch let error as StreamError where error == .insufficientData {
            throw ParseError.unexpectedEnd
        }
    }
}
