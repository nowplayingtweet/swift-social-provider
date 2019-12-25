import XCTest
@testable import SocialProtocol

final class SocialErrorTests: XCTestCase {

    static var allTests = [
        ("Test SocialError.localizedDescription", testSocialErrorLocalizedDescription),
    ]

    func testSocialErrorLocalizedDescription() {
        XCTAssertEqual(SocialError.FailedAuthorize("message").localizedDescription,
                       "failed authorize: message")
        XCTAssertEqual(SocialError.FailedRevoke("message").localizedDescription,
                       "failed revoke: message")
        XCTAssertEqual(SocialError.FailedVerify("message").localizedDescription,
                       "failed verify: message")
        XCTAssertEqual(SocialError.FailedPost("message").localizedDescription,
                       "failed post: message")
        XCTAssertEqual(SocialError.NotImplements(className: "ClassName", function: "functionName(_:)").localizedDescription,
                       "Not implements ClassName.functionName(_:)")
    }

}
