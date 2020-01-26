import XCTest
@testable import MastodonProvider

import SocialProtocol

final class MastodonClientStaticFunctionTests: XCTestCase {

    static var allTests = [
        ("testHandleCallback", testHandleCallback),
        ("testRegisterApp", testRegisterApp),
        ("testPublicRegisterAppInvalidURL", testPublicRegisterAppInvalidURL),
        ("testRegisterAppErrorHandling", testRegisterAppErrorHandling),
        ("testRegisterAppInvalidResponse", testRegisterAppInvalidResponse),
        ("testRegisterAppErrorResponse", testRegisterAppErrorResponse),
        ("testRegisterAppInvalidObject", testRegisterAppInvalidObject),
    ]

    func testHandleCallback() {
        let url = URL(string: "https://social.test/url")!
        NotificationCenter.default.addObserver(forName: .callbackMastodon, object: nil, queue: nil) { notification in
            XCTAssertEqual(notification.userInfo?["url"] as? URL, url)
        }
        MastodonClient.handleCallback(url)
    }

    func testRegisterApp() {
        let client = HTTPClientMock(body: "{ \"client_id\": \"id string\", \"client_secret\": \"secret string\" }".data(using: .utf8))
        MastodonClient.registerApp(client, base: "https://social.test", name: "test app", redirectUri: "urn:ietf:wg:oauth:2.0:oob", success: { id, secret in
            XCTAssertEqual(id, "id string")
            XCTAssertEqual(secret, "secret string")
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

    func testRegisterAppErrorHandling() {
        let responseError = URLError(.cannotConnectToHost)
        let client = HTTPClientMock(error: responseError)
        MastodonClient.registerApp(client, base: "https://social.invalid", name: "test app", redirectUri: "urn:ietf:wg:oauth:2.0:oob", success: { _,_ in
            XCTFail()
        }, failure: { error in
            XCTAssertEqual(error.localizedDescription, responseError.localizedDescription)
        })
    }

    func testRegisterAppInvalidResponse() {
        let client = HTTPClientMock(statusCode: 403, body: nil)
        MastodonClient.registerApp(client, base: "https://social.invalid", name: "test app", redirectUri: "urn:ietf:wg:oauth:2.0:oob", success: { _,_ in
            XCTFail()
        }, failure: { error in
            XCTAssertEqual(error.localizedDescription, SocialError.failedAuthorize("Invalid response.").localizedDescription)
        })
    }

    func testRegisterAppErrorResponse() {
        let client = HTTPClientMock(statusCode: 403, body: "{ \"error\": \"message\" }".data(using: .utf8))
        MastodonClient.registerApp(client, base: "https://social.invalid", name: "test app", redirectUri: "urn:ietf:wg:oauth:2.0:oob", success: { _,_ in
            XCTFail()
        }, failure: { error in
            XCTAssertEqual(error.localizedDescription, SocialError.failedAuthorize("403").localizedDescription)
        })
    }

    func testRegisterAppInvalidObject() {
        let client = HTTPClientMock(body: "{ \"client_id\": \"id string\" }".data(using: .utf8))
        MastodonClient.registerApp(client, base: "https://social.invalid", name: "test app", redirectUri: "urn:ietf:wg:oauth:2.0:oob", success: { _,_ in
            XCTFail()
        }, failure: { error in
            XCTAssertEqual(error.localizedDescription, SocialError.failedAuthorize("Invalid response.").localizedDescription)
        })
    }

}
