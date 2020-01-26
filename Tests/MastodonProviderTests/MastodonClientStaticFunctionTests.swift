import XCTest
@testable import MastodonProvider

import SocialProtocol

final class MastodonClientStaticFunctionTests: XCTestCase {

    static var allTests = [
        ("testHandleCallback", testHandleCallback),
        ("testRegisterApp", testRegisterApp),
        ("testPublicRegisterAppInvalidURL", testPublicRegisterAppInvalidURL),
        ("testRegisterAppClientError", testRegisterAppClientError),
        ("testRegisterAppErrorResponse", testRegisterAppErrorResponse),
        ("testRegisterAppInvalidResponse", testRegisterAppInvalidResponse),
    ]

    func testHandleCallback() {
        let url = URL(string: "https://social.test/url")!
        NotificationCenter.default.addObserver(forName: .callbackMastodon, object: nil, queue: nil) { notification in
            XCTAssertEqual(notification.userInfo?["url"] as? URL, url)
        }
        MastodonClient.handleCallback(url)
    }

    func testRegisterApp() {
        let name = "test app"
        let redirectUri = "urn:ietf:wg:oauth:2.0:oob"
        let client = HTTPClientMock(body: """
        {
            "id": "2357",
            "name": "\(name)",
            "website": null,
            "redirect_uri": "\(redirectUri)",
            "client_id": "client id",
            "client_secret": "client secret"
        }
        """.data(using: .utf8))
        MastodonClient.registerApp(client, base: "https://social.test", name: name, redirectUri: redirectUri, success: { id, secret in
            XCTAssertEqual(id, "client id")
            XCTAssertEqual(secret, "client secret")
        }, failure: { error in
            XCTFail()
        })
    }

    func testPublicRegisterAppInvalidURL() {
        MastodonClient.registerApp(base: "social.invalid", name: "test app", redirectUri: "urn:ietf:wg:oauth:2.0:oob", success: { _,_ in
            XCTFail()
        }, failure: { error in
            XCTAssertEqual(error.localizedDescription, SocialError.invalidURL(string: "social.invalid").localizedDescription)
        })
    }

    func testRegisterAppClientError() {
        let responseError = URLError(.cannotConnectToHost)
        let client = HTTPClientMock(error: responseError)
        MastodonClient.registerApp(client, base: "https://social.invalid", name: "test app", redirectUri: "urn:ietf:wg:oauth:2.0:oob", success: { _,_ in
            XCTFail()
        }, failure: { error in
            XCTAssertEqual(error.localizedDescription, responseError.localizedDescription)
        })
    }

    func testRegisterAppErrorResponse() {
        let client = HTTPClientMock(statusCode: 422, body: """
        {
            "error": "Validation failed: Redirect URI must be an absolute URI."
        }
        """.data(using: .utf8))
        MastodonClient.registerApp(client, base: "https://social.invalid", name: "test app", redirectUri: "urn:ietf:wg:oauth:2.0:oob", success: { _,_ in
            XCTFail()
        }, failure: { error in
            XCTAssertEqual(error.localizedDescription, SocialError.failedAuthorize("422").localizedDescription)
        })
    }

    func testRegisterAppInvalidResponse() {
        let name = "test app"
        let redirectUri = "urn:ietf:wg:oauth:2.0:oob"
        let client = HTTPClientMock(body: """
        {
            "id": "2357",
            "name": "\(name)",
            "website": null,
            "redirect_uri": "\(redirectUri)",
            "client_id": "client id"
        }
        """.data(using: .utf8))
        MastodonClient.registerApp(client, base: "https://social.invalid", name: name, redirectUri: redirectUri, success: { _,_ in
            XCTFail()
        }, failure: { error in
            XCTAssertEqual(error.localizedDescription, SocialError.failedAuthorize("Invalid response.").localizedDescription)
        })
    }

}
