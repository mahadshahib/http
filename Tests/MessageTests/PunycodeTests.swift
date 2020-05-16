import Test
import HTTP

class PunycodeTests: TestCase {
    func testEncode() {
        let encoded = Punycode.encode(domain: "привет.рф")
        expect(encoded == "xn--b1agh1afp.xn--p1ai")
    }

    func testDecode() {
        let decoded = Punycode.decode(domain: "xn--b1agh1afp.xn--p1ai")
        expect(decoded == "привет.рф")
    }

    func testEncodeMixedCase() {
        let encoded = Punycode.encode(domain: "Привет.рф")
        expect(encoded == "xn--r0a2bjk3bp.xn--p1ai")
    }

    func testDecodeMixedCase() {
        let decoded = Punycode.decode(domain: "xn--r0a2bjk3bp.xn--p1ai")
        expect(decoded == "Привет.рф")
    }

    func testEncodeMixedASCII() {
        let encoded = Punycode.encode(domain: "hello-мир.рф")
        expect(encoded == "xn--hello--upf5a1b.xn--p1ai")
    }

    func testDecodeMixedASCII() {
        let decoded = Punycode.decode(domain: "xn--hello--upf5a1b.xn--p1ai")
        expect(decoded == "hello-мир.рф")
    }
}
