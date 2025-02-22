import Test

@testable import HTTP

test.case("KeyedDecoder") {
    let values = ["first":"one","second":"two"]
    struct Model: Decodable {
        let first: String
        let second: String?
    }
    let object = try Model(from: KeyValueDecoder(values))
    expect(object.first == "one")
    expect(object.second == "two")
}

test.case("SingleValueDecoder") {
    let value = ["integer":"42"]
    let integer = try Int(from: KeyValueDecoder(value))
    expect(integer == 42)
}

test.run()
