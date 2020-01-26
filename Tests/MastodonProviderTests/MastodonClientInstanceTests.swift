import XCTest
@testable import MastodonProvider

import SocialProtocol

final class MastodonClientInstanceTests: XCTestCase {

    static var allTests = [
        ("testInitializeWithKeySecret", testInitializeWithKeySecret),
        ("testInitializeWithCredentials", testInitializeWithCredentials),
    ]

    func testInitializeWithKeySecret() {
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

}
