import struct Foundation.Date
import struct Foundation.TimeZone
import class Foundation.DateFormatter

extension Response {
    public struct SetCookie {
        public var cookie: Cookie
        public var domain: String? = nil
        public var path: String? = nil
        public var expires: Date? = nil
        public var maxAge: Int? = nil
        public var secure: Bool? = nil
        public var httpOnly: Bool? = nil

        public init(
            _ cookie: Cookie,
            domain: String? = nil,
            path: String? = nil,
            expires: Date? = nil,
            maxAge: Int? = nil,
            secure: Bool? = nil,
            httpOnly: Bool? = nil
        ) {
            self.cookie = cookie
            self.domain = domain
            self.path = path
            self.expires = expires
            self.maxAge = maxAge
            self.secure = secure
            self.httpOnly = httpOnly
        }
    }
}

extension Response.SetCookie: Equatable {
    public typealias SetCookie = Response.SetCookie
    public static func ==(lhs: SetCookie, rhs: SetCookie) -> Bool {
        return lhs.cookie == rhs.cookie &&
            lhs.domain == rhs.domain &&
            lhs.path == rhs.path &&
            lhs.expires == rhs.expires &&
            lhs.maxAge == rhs.maxAge &&
            lhs.secure == rhs.secure &&
            lhs.httpOnly == rhs.httpOnly
    }
}

extension Response.SetCookie {
    struct Bytes {
        static let expires = ASCII("Expires")
        static let maxAge = ASCII("Max-Age")
        static let domain = ASCII("Domain")
        static let path = ASCII("Path")

        static let httpOnly = ASCII("HttpOnly")
        static let secure = ASCII("Secure")
    }

    init(from bytes: RandomAccessSlice<UnsafeRawBufferPointer>) throws {
        var startIndex = bytes.startIndex
        var endIndex = bytes.index(of: Character.semicolon, offset: startIndex)
            ?? bytes.endIndex

        self.cookie = try Cookie(from: bytes[startIndex..<endIndex])
        startIndex = endIndex + 1
        endIndex = startIndex


        while endIndex < bytes.endIndex {
            endIndex =
                bytes.index(of: Character.semicolon, offset: startIndex) ??
                bytes.endIndex

            // should be separated by a semi-colon and a space ('; ')
            guard bytes[startIndex] == Character.whitespace else {
                throw HTTPError.invalidSetCookie
            }
            startIndex += 1

            if let equalIndex = bytes.index(
                of: Character.equal, offset: startIndex) {
                // attribute name=value
                let valueStartIndex = equalIndex + 1
                guard valueStartIndex < endIndex else {
                    throw HTTPError.invalidSetCookie
                }
                let attributeName = bytes[startIndex..<equalIndex]
                let attributeValue = bytes[valueStartIndex..<endIndex]

                // TODO: validate values using special rules
                switch attributeName.lowercasedHashValue {
                case Bytes.domain.lowercasedHashValue:
                    self.domain = String(validating: attributeValue, as: .text)
                case Bytes.path.lowercasedHashValue:
                    self.path = String(validating: attributeValue, as: .text)
                case Bytes.expires.lowercasedHashValue:
                    guard let dateString =
                            String(validating: attributeValue, as: .text),
                        let date = Date(from: dateString) else {
                            throw HTTPError.invalidSetCookie
                    }
                    self.expires = date
                case Bytes.maxAge.lowercasedHashValue:
                    guard let maxAgeString =
                        String(validating: attributeValue, as: .text),
                        let maxAge = Int(maxAgeString) else {
                            throw HTTPError.invalidSetCookie
                    }
                    self.maxAge = maxAge
                default:
                    throw HTTPError.invalidSetCookie
                }
            } else {
                // single attribute
                switch bytes[startIndex..<endIndex].lowercasedHashValue {
                case Bytes.httpOnly.lowercasedHashValue: self.httpOnly = true
                case Bytes.secure.lowercasedHashValue: self.secure = true
                default: throw HTTPError.invalidSetCookie
                }
            }

            startIndex = endIndex + 1
        }
    }

    func encode(to buffer: inout [UInt8]) {
        cookie.encode(to: &buffer)
        if let domain = self.domain {
            buffer.append(Character.semicolon)
            buffer.append(Character.whitespace)
            buffer.append(contentsOf: Bytes.domain)
            buffer.append(Character.equal)
            buffer.append(contentsOf: domain.utf8)
        }
        if let path = self.path {
            buffer.append(Character.semicolon)
            buffer.append(Character.whitespace)
            buffer.append(contentsOf: Bytes.path)
            buffer.append(Character.equal)
            buffer.append(contentsOf: path.utf8)
        }
        if let expires = self.expires {
            buffer.append(Character.semicolon)
            buffer.append(Character.whitespace)
            buffer.append(contentsOf: Bytes.expires)
            buffer.append(Character.equal)
            expires.encode(to: &buffer)
        }
        if let maxAge = self.maxAge {
            buffer.append(Character.semicolon)
            buffer.append(Character.whitespace)
            buffer.append(contentsOf: Bytes.maxAge)
            buffer.append(Character.equal)
            buffer.append(contentsOf: String(describing: maxAge).utf8)
        }
        if self.secure == true {
            buffer.append(Character.semicolon)
            buffer.append(Character.whitespace)
            buffer.append(contentsOf: Bytes.secure)
        }
        if self.httpOnly == true {
            buffer.append(Character.semicolon)
            buffer.append(Character.whitespace)
            buffer.append(contentsOf: Bytes.httpOnly)
        }
    }
}

extension Date {
    static var formatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.dateFormat = "EEE, dd MMM yyyy HH:mm:ss z"
        return formatter
    }

    init?(from string: String) {
        guard let date = Date.formatter.date(from: string) else {
            return nil
        }
        self = date
    }

    func encode(to buffer: inout [UInt8]) {
        buffer.append(contentsOf: Date.formatter.string(from: self).utf8)
    }
}
