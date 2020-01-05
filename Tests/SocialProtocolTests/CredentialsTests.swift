import XCTest
@testable import SocialProtocol

final class CredentialsTests: XCTestCase {

    static var allTests = [
        ("Test Credentials.oauthVersion", testOAuthVersion),
    ]

    func testOAuthVersion() {
        XCTAssertEqual(OAuth.One, TestOAuth1Credentials.oauthVersion)
        XCTAssertEqual(OAuth.Two, TestOAuth2Credentials.oauthVersion)
    }

}
