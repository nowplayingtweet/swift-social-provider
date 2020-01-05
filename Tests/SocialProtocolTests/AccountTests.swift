import XCTest
@testable import SocialProtocol

final class AccountTests: XCTestCase {

    static var allTests = [
        ("Test Account.isEqual/1", testIsEqual),
    ]

    func testIsEqual() {
        let testAccount = TestAccount(id: "1")

        let testD14nAccountOne = TestD14nAccount(domain: "mastodon.test", id: "1")
        let testD14nAccountTwo = TestD14nAccount(domain: "pleroma.test", id: "1")

        XCTAssertTrue(testAccount.isEqual(testAccount))
        XCTAssertFalse(testAccount.isEqual(nil))

        XCTAssertTrue(testD14nAccountOne.isEqual(testD14nAccountOne))
        XCTAssertFalse(testD14nAccountOne.isEqual(testD14nAccountTwo))
        XCTAssertFalse(testD14nAccountOne.isEqual(testAccount))
        XCTAssertFalse(testD14nAccountOne.isEqual(nil))
    }

}
