import XCTest
@testable import SocialProtocol

final class SocialErrorTests: XCTestCase {

    static var allTests = [
        ("testSocialErrorLocalizedDescription", testSocialErrorLocalizedDescription),
    ]

    func testSocialErrorLocalizedDescription() {
        XCTAssertEqual(SocialError.invalidURL(string: "無効なURL").localizedDescription,
                       "Invalid URL: 無効なURL")
        XCTAssertEqual(SocialError.failedAuthorize("message").localizedDescription,
                       "Failed authorize: message")
        XCTAssertEqual(SocialError.failedRevoke("message").localizedDescription,
                       "Failed revoke: message")
        XCTAssertEqual(SocialError.failedVerify("message").localizedDescription,
                       "Failed verify: message")
        XCTAssertEqual(SocialError.failedPost("message").localizedDescription,
                       "Failed post: message")
        XCTAssertEqual(SocialError.notImplements(className: "ClassName", function: "functionName(_:)").localizedDescription,
                       "Not implements ClassName.functionName(_:)")
    }

}
