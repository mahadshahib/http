public enum Version {
    case oneOne
}

extension Version {
    init(from buffer: UnsafeRawBufferPointer) throws {
        guard buffer.starts(with: Constants.httpSlash) else {
            throw RequestError.invalidVersion
        }
        guard buffer.count >= 8,
            buffer[5..<8].elementsEqual(Constants.oneOne) else {
                throw RequestError.invalidVersion
        }
        self = .oneOne
    }
}

extension Version {
    var bytes: [UInt8] {
        switch self {
        case .oneOne: return Constants.oneOne
        }
    }
}
