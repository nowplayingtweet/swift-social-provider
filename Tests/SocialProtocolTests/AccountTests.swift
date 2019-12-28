import XCTest
@testable import SocialProtocol

private struct TestAccount: Account {
    static var provider: Provider = Provider(rawValue: "Test")

    let id: String
    let name: String = "Test Account"
    let username: String = "test_account"
    let avaterUrl: URL = URL(string: "https://social.test/image.png")!
}

private struct TestD14nAccount: D14nAccount {
    static var provider: Provider = Provider(rawValue: "TestD14n")

    let domain: String
    let id: String
    let name: String = "Test D14n Account"
    let username: String = "test_d14n_account"
    let avaterUrl: URL = URL(string: "https://social.test/image.png")!
}

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
