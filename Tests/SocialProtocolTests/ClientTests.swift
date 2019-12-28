import XCTest
@testable import SocialProtocol

private struct TestAccount: Account {
    static var provider: Provider = Provider(rawValue: "")

    let id: String = ""
    let name: String = ""
    let username: String = ""
    let avaterUrl: URL = URL(string: "https://social.test/image.png")!
}

private struct TestCredentials: Credentials, OAuth2 {
    let apiKey: String = ""
    let apiSecret: String = ""
    let oauthToken: String = ""
}

private class TestClient: Client {
    let credentials: Credentials
    var userAgent: String?

    required init?(_ credentials: Credentials, userAgent: String?) {
        self.credentials = credentials
        self.userAgent = userAgent
    }

    func revoke(success: Client.Success?, failure: Client.Failure?) {
        XCTAssertNil(success)
        XCTAssertNil(failure)
    }

    func verify(success: @escaping Client.AccountSuccess, failure: Client.Failure?) {
        XCTAssertNil(failure)
    }

    func post(text: String, otherParams: [String : String]?, success: Client.Success?, failure: Client.Failure?) {
        XCTAssertNil(otherParams)
    }
}

extension TestClient: D14nClient {
    static func registerApp(base: String, name: String, redirectUri: String, success: @escaping D14nClient.RegisterSuccess, failure: Client.Failure?) {
        XCTAssertEqual(redirectUri, "urn:ietf:wg:oauth:2.0:oob")
    }
}

extension TestClient: PostAttachments {
    func post(text: String, image: Data?, otherParams: [String : String]?, success: Client.Success?, failure: Client.Failure?) {
        XCTAssertNil(image)
        XCTAssertNil(otherParams)
    }
}

extension TestClient: AuthorizeByCallback, AuthorizeByCode {
    static func handleCallback(_: NSAppleEventDescriptor) {}

    static func authorize(key: String, secret: String, redirectUri: String, success: @escaping Client.TokenSuccess, failure: Client.Failure?) {
        XCTAssertNil(failure)
    }

    static func authorize(key: String, secret: String, failure: Client.Failure?) {
        XCTAssertNil(failure)
    }

    static func requestToken(key: String, secret: String, code: String, success: @escaping Client.TokenSuccess, failure: Client.Failure?) {
        XCTAssertNil(failure)
    }
}

extension TestClient: D14nAuthorizeByCallback, D14nAuthorizeByCode {
    static func authorize(base: String, key: String, secret: String, redirectUri: String, success: @escaping Client.TokenSuccess, failure: Client.Failure?) {
        XCTAssertNil(failure)
    }

    static func authorize(base: String, key: String, secret: String, failure: Client.Failure?) {
        XCTAssertNil(failure)
    }

    static func requestToken(base: String, key: String, secret: String, code: String, success: @escaping Client.TokenSuccess, failure: Client.Failure?) {
        XCTAssertNil(failure)
    }
}

final class ClientTests: XCTestCase {

    static var allTests = [
        ("Test fallback Client initalizer", testFallbackInitializer),
        ("Test fallback Client functions", testFallbackFunctions),
        ("Test fallback Client siatic functions", testFallbackStaticFunctions),
    ]

    func testFallbackInitializer() {
        let client = TestClient(TestCredentials())
        XCTAssertNil(client?.userAgent)
    }

    func testFallbackFunctions() {
        let client = TestClient(TestCredentials(), userAgent: nil)!
        client.revoke()
        client.verify(success: { _ in })
        client.post(text: "")

        // PostAttachments
        client.post(text: "", image: nil)
    }

    func testFallbackStaticFunctions() {
        // D14nClient
        TestClient.registerApp(base: "", name: "", success: { _,_ in })

        // AuthorizeByCallback, D14nAuthorizeByCallback
        TestClient.authorize(key: "", secret: "", redirectUri: "", success: { _ in })
        TestClient.authorize(base: "", key: "", secret: "", redirectUri: "", success: { _ in })

        // AuthorizeByCode, D14nAuthorizeByCode
        TestClient.authorize(key: "", secret: "")
        TestClient.authorize(base: "", key: "", secret: "")
        TestClient.requestToken(key: "", secret: "", code: "", success: { _ in })
        TestClient.requestToken(base: "", key: "", secret: "", code: "", success: { _ in })
    }

}
