import XCTest
@testable import SocialProtocol

final class CredentialsTests: XCTestCase {

    static var allTests = [
        ("testOAuthVersion", testOAuthVersion),
    ]

    func testOAuthVersion() {
        XCTAssertEqual(TestOAuth1Credentials.oauthVersion, OAuth.One)
        XCTAssertEqual(TestOAuth2Credentials.oauthVersion, OAuth.Two)
    }

}
