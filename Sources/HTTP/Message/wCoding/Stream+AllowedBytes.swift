import Stream

final class AllowedBytes {
    @_versioned
    let buffer: UnsafeBufferPointer<Bool>

    init(byteSet set: Set<UInt8>) {
        let buffer = UnsafeMutableBufferPointer<Bool>.allocate(capacity: 256)
        buffer.initialize(repeating: false)
        for byte in set {
            buffer[Int(byte)] = true
        }
        self.buffer = UnsafeBufferPointer(buffer)
    }

    init(usASCII table: ASCIITable) {
        let buffer = UnsafeMutableBufferPointer<Bool>.allocate(capacity: 256)
        buffer.initialize(repeating: false)

        var copy = table
        let pointer = UnsafeMutableRawPointer(mutating: &copy)
            .assumingMemoryBound(to: Bool.self)
        let asciiBuffer = UnsafeBufferPointer(start: pointer, count: 128)
        _ = buffer.initialize(from: asciiBuffer)

        self.buffer = UnsafeBufferPointer(buffer)
    }

    deinit {
        buffer.deallocate()
    }
}

extension StreamReader {
    @inline(__always)
    func read(allowedBytes: AllowedBytes) throws -> [UInt8] {
        let buffer = allowedBytes.buffer
        return try read(while: { buffer[Int($0)] })
    }

    @inline(__always)
    func read<T>(
        allowedBytes: AllowedBytes,
        body: (UnsafeRawBufferPointer) throws -> T
    ) throws -> T {
        let buffer = allowedBytes.buffer
        return try read(
            while: { buffer[Int($0)] },
            allowingExhaustion: true,
            body: body)
    }
}

typealias ASCIITable = (
    Bool, Bool, Bool, Bool, Bool, Bool, Bool, Bool,
    Bool, Bool, Bool, Bool, Bool, Bool, Bool, Bool,
    Bool, Bool, Bool, Bool, Bool, Bool, Bool, Bool,
    Bool, Bool, Bool, Bool, Bool, Bool, Bool, Bool,
    Bool, Bool, Bool, Bool, Bool, Bool, Bool, Bool,
    Bool, Bool, Bool, Bool, Bool, Bool, Bool, Bool,
    Bool, Bool, Bool, Bool, Bool, Bool, Bool, Bool,
    Bool, Bool, Bool, Bool, Bool, Bool, Bool, Bool,
    Bool, Bool, Bool, Bool, Bool, Bool, Bool, Bool,
    Bool, Bool, Bool, Bool, Bool, Bool, Bool, Bool,
    Bool, Bool, Bool, Bool, Bool, Bool, Bool, Bool,
    Bool, Bool, Bool, Bool, Bool, Bool, Bool, Bool,
    Bool, Bool, Bool, Bool, Bool, Bool, Bool, Bool,
    Bool, Bool, Bool, Bool, Bool, Bool, Bool, Bool,
    Bool, Bool, Bool, Bool, Bool, Bool, Bool, Bool,
    Bool, Bool, Bool, Bool, Bool, Bool, Bool, Bool)
