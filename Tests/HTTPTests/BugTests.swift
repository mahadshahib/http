import XCTest
@testable import HTTP

class BugTests: TestCase {
    let simpleGet = ASCII("GET /test HTTP/1.1\r\n\r\n")
    func testStringTerminationBug() {
        if !_isDebugAssertConfiguration() {
            for _ in 0..<1_000_000 {
                if let request = try? Request(from: simpleGet) {
                    if request.url.path != "/test" {
                        fail("(\"\(request.url)\") in not equal to (\"Optional(\"/test\")\")")
                        break
                    }
                }
            }
        }
    }
}
