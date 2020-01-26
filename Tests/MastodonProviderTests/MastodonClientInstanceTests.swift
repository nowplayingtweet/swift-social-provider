import XCTest
@testable import MastodonProvider

import SocialProtocol

final class MastodonClientInstanceTests: XCTestCase {

    static var allTests = [
        ("testInitializeWithKeySecret", testInitializeWithKeySecret),
        ("testInitializeWithCredentials", testInitializeWithCredentials),
        ("testAuthorizeURL", testAuthorizeURL),
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

    func testAuthorizeURL() {
        let authorizeURL = URL(string: "https://social.test/oauth/authorize?client_id=key&client_secret=secret&redirect_uri=urn:ietf:wg:oauth:2.0:oob&scopes=read%20write&response_type=code")

        let httpClient = HTTPClientMock()
        let client = MastodonClient(base: "https://social.test", key: "key", secret: "secret", httpClient: httpClient)
        XCTAssertNotNil(client)

        client?.authorize(openURL: { url in
            XCTAssertEqual(url, authorizeURL)
        }, failure: { _ in
            XCTFail()
        })
    }

}
