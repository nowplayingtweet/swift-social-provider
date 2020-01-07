import XCTest
@testable import SocialProtocol

final class ClientTests: XCTestCase {

    static var allTests = [
        ("testFallbackInitializer", testFallbackInitializer),
    ]

    func testFallbackInitializer() {
        guard let client = TestC12nClient(TestOAuth2Credentials()) else {
            XCTFail("Invalid credentials.")
            return
        }
        XCTAssertNil(client.userAgent)

        let c12nClient = TestC12nClient(key: "key", secret: "secret", userAgent: "user-agent")
        XCTAssertEqual(c12nClient.userAgent, "user-agent")

        let d14nClient = TestD14nClient(base: "d14n-base", key: "d14n-key", secret: "d14n-secret", userAgent: "d14n-user-agent")
        XCTAssertEqual(d14nClient.userAgent, "d14n-user-agent")
    }

}
