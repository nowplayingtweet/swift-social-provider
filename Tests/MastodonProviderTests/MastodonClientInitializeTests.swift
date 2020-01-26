import XCTest
@testable import MastodonProvider

import SocialProtocol

private struct TestCredentials: D14nCredentials, OAuth2 {
    static var oauthVersion: OAuth = .Two

    var base: String
    var apiKey: String
    var apiSecret: String

    var oauthToken: String
}

final class MastodonClientInitializeTests: XCTestCase {

    static var allTests = [
        ("testInitialize", testInitialize),
        ("testInitializeWithCredentials", testInitializeWithCredentials),
        ("testInitializeInvalidCredentials", testInitializeInvalidCredentials),
        ("testInitializeInvalidBaseURL", testInitializeInvalidBaseURL),
    ]

    func testInitialize() {
        let client = MastodonClient(base: "https://social.test", key: "key", secret: "secret")
        XCTAssertNotNil(client)

        XCTAssertEqual(client?.base, "https://social.test")
        XCTAssertEqual(client?.key, "key")
        XCTAssertEqual(client?.secret, "secret")
    }

    func testInitializeWithCredentials() {
        let credentials = MastodonCredentials(base: "https://social.test", apiKey: "key", apiSecret: "secret", oauthToken: "token")
        let client = MastodonClient(credentials)
        XCTAssertNotNil(client)

        XCTAssertEqual(client?.base, "https://social.test")
        XCTAssertEqual(client?.key, "key")
        XCTAssertEqual(client?.secret, "secret")

        let clientCredentials = client?.credentials as? MastodonCredentials
        XCTAssertNotNil(clientCredentials)

        XCTAssertEqual(clientCredentials?.oauthToken, credentials.oauthToken)
    }

    func testInitializeInvalidCredentials() {
        let credentials = TestCredentials(base: "https://social.invalid", apiKey: "key", apiSecret: "secret", oauthToken: "token")
        let client = MastodonClient(credentials)
        XCTAssertNil(client)
    }

    func testInitializeInvalidBaseURL() {
        XCTAssertNil(MastodonClient(base: "social.invalid", key: "key", secret: "secret"))

        let credentials = MastodonCredentials(base: "social.invalid", apiKey: "key", apiSecret: "secret", oauthToken: "token")
        XCTAssertNil(MastodonClient(credentials))
    }

}
