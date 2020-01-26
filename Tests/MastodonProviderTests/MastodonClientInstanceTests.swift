import XCTest
@testable import MastodonProvider

import SocialProtocol

final class MastodonClientInstanceTests: XCTestCase {

    static var allTests = [
        ("testInitializeWithKeySecret", testInitializeWithKeySecret),
        ("testInitializeWithCredentials", testInitializeWithCredentials),
    ]

    func testInitializeWithKeySecret() {
        let client = MastodonClient(base: "base", key: "key", secret: "secret")

        XCTAssertEqual(client.base, "base")
        XCTAssertEqual(client.key, "key")
        XCTAssertEqual(client.secret, "secret")
    }

    func testInitializeWithCredentials() {
        let credentials = MastodonCredentials(base: "base", apiKey: "key", apiSecret: "secret", oauthToken: "token")
        let client = MastodonClient(credentials)

        XCTAssertNotNil(client)

        XCTAssertEqual(client?.base, "base")
        XCTAssertEqual(client?.key, "key")
        XCTAssertEqual(client?.secret, "secret")

        let clientCredentials = client?.credentials as? MastodonCredentials
        XCTAssertNotNil(clientCredentials)

        XCTAssertEqual(clientCredentials?.oauthToken, credentials.oauthToken)
    }

}
