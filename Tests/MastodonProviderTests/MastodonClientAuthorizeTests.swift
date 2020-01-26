import XCTest
@testable import MastodonProvider

import SocialProtocol

final class MastodonClientAuthorizeTests: XCTestCase {

    static var allTests = [
        ("testAuthorizeURL", testAuthorizeURL),
        ("testAuthorizeRedirectCallback", testAuthorizeRedirectCallback),
        ("testAuthorizeSkipInvalidURLEvent", testAuthorizeSkipInvalidURLEvent),
        ("testRequestToken", testRequestToken),
        ("testRequestTokenClientError", testRequestTokenClientError),
        ("testRequestTokenErrorResponse", testRequestTokenErrorResponse),
        ("testRequestTokenInvalidResponse", testRequestTokenInvalidResponse),
    ]

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

    func testAuthorizeRedirectCallback() {
        let authorizeURL = URL(string: "https://social.test/oauth/authorize?client_id=key&client_secret=secret&redirect_uri=test-scheme://&scopes=read%20write&response_type=code")

        let httpClient = HTTPClientMock()
        let client = MastodonClient(base: "https://social.test", key: "key", secret: "secret", httpClient: httpClient)
        XCTAssertNotNil(client)

        client?.authorize(redirectUri: "test-scheme://", openURL: { url in
            XCTAssertEqual(url, authorizeURL)
            let httpClient = HTTPClientMock(body: """
            {
                "access_token": "authorization-token",
                "token_type": "Bearer",
                "scope": "read write",
                "created_at": 1234567890
            }
            """.data(using: .utf8))
            client?.client = httpClient
            NotificationQueue.default.enqueue(.init(name: .callbackMastodon,
                                                    userInfo: ["url": URL(string: "test-scheme://?code=code")!]),
                                              postingStyle: .now)
        }, success: { credentials in
            guard let credentials = credentials as? MastodonCredentials
                , let clientCredentials = client?.credentials as? MastodonCredentials else {
                    XCTFail()
                    return
            }
            XCTAssertEqual(credentials.base, "https://social.test")
            XCTAssertEqual(credentials.apiKey, "key")
            XCTAssertEqual(credentials.apiSecret, "secret")
            XCTAssertEqual(credentials.oauthToken, "authorization-token")
            XCTAssertEqual(clientCredentials.oauthToken, "authorization-token")
        }, failure: { _ in
            XCTFail()
        })
    }

    func testAuthorizeSkipInvalidURLEvent() {
        let httpClient = HTTPClientMock()
        let client = MastodonClient(base: "https://social.test", key: "key", secret: "secret", httpClient: httpClient)
        XCTAssertNotNil(client)

        client?.authorize(redirectUri: "test-scheme://", openURL: { _ in
            NotificationQueue.default.enqueue(.init(name: .callbackMastodon,
                                                    userInfo: ["url": URL(string: "test-scheme://")!]),
                                              postingStyle: .now)
        }, success: { credentials in
            XCTFail()
        }, failure: { _ in
            XCTFail()
        })
    }

    func testRequestToken() {
        let httpClient = HTTPClientMock(body: """
        {
            "access_token": "authorization-token",
            "token_type": "Bearer",
            "scope": "read write",
            "created_at": 1234567890
        }
        """.data(using: .utf8))
        let client = MastodonClient(base: "https://social.test", key: "key", secret: "secret", httpClient: httpClient)
        XCTAssertNotNil(client)

        client?.requestToken(code: "code", success: { credentials in
            guard let credentials = credentials as? MastodonCredentials
                , let clientCredentials = client?.credentials as? MastodonCredentials else {
                    XCTFail()
                    return
            }
            XCTAssertEqual(credentials.base, "https://social.test")
            XCTAssertEqual(credentials.apiKey, "key")
            XCTAssertEqual(credentials.apiSecret, "secret")
            XCTAssertEqual(credentials.oauthToken, "authorization-token")
            XCTAssertEqual(clientCredentials.oauthToken, "authorization-token")
        }, failure: { _ in
            XCTFail()
        })
    }

    func testRequestTokenClientError() {
        let responseError = URLError(.cannotConnectToHost)
        let httpClient = HTTPClientMock(error: responseError)
        let client = MastodonClient(base: "https://social.invalid", key: "key", secret: "secret", httpClient: httpClient)
        XCTAssertNotNil(client)

        client?.requestToken(code: "code", success: { _ in
            XCTFail()
        }, failure: { error in
            XCTAssertEqual(error.localizedDescription, responseError.localizedDescription)
        })
    }

    func testRequestTokenErrorResponse() {
        let httpClient400 = HTTPClientMock(statusCode: 400, body: """
        {
            "error": "invalid_scope",
            "error_description": "The requested scope is invalid, unknown, or malformed."
        }
        """.data(using: .utf8))
        let httpClient401 = HTTPClientMock(statusCode: 401, body: """
        {
            "error": "invalid_client",
            "error_description": "Client authentication failed due to unknown client, no client authentication included, or unsupported authentication method."
        }
        """.data(using: .utf8))

        let client = MastodonClient(base: "https://social.invalid", key: "key", secret: "secret", httpClient: httpClient400)
        XCTAssertNotNil(client)

        client?.requestToken(code: "code", success: { _ in
            XCTFail()
        }, failure: { error in
            XCTAssertEqual(error.localizedDescription, SocialError.failedAuthorize("400").localizedDescription)
        })

        client?.client = httpClient401
        client?.requestToken(code: "code", success: { _ in
            XCTFail()
        }, failure: { error in
            XCTAssertEqual(error.localizedDescription, SocialError.failedAuthorize("401").localizedDescription)
        })
    }

    func testRequestTokenInvalidResponse() {
        let httpClient = HTTPClientMock()
        let client = MastodonClient(base: "https://social.invalid", key: "key", secret: "secret", httpClient: httpClient)
        XCTAssertNotNil(client)

        client?.requestToken(code: "code", success: { _ in
            XCTFail()
        }, failure: { error in
            XCTAssertEqual(error.localizedDescription, SocialError.failedAuthorize("Invalid response.").localizedDescription)
        })
    }

}
