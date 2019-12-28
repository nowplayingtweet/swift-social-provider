import XCTest
@testable import SocialProtocol

private struct TestOAuth1Credentials: Credentials, OAuth1 {
    let apiKey: String = ""
    let apiSecret: String = ""
    let oauthToken: String = ""
    let oauthSecret: String = ""
}

private struct TestOAuth2Credentials: Credentials, OAuth2 {
    let apiKey: String = ""
    let apiSecret: String = ""
    let oauthToken: String = ""
}

final class CredentialsTests: XCTestCase {

    static var allTests = [
        ("Test Credentials.oauthVersion", testOAuthVersion),
    ]

    func testOAuthVersion() {
        XCTAssertEqual(OAuth.One, TestOAuth1Credentials.oauthVersion)
        XCTAssertEqual(OAuth.Two, TestOAuth2Credentials.oauthVersion)
    }

}
