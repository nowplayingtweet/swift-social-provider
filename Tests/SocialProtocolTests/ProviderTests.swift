import XCTest
@testable import SocialProtocol

final class ProviderTests: XCTestCase {

    static var allTests = [
        ("testProviderComparable", testProviderComparable),
    ]

    func testProviderComparable() {
        let providerOne = Provider(rawValue: "One")
        let providerTwo = Provider(rawValue: "Two")
        XCTAssertEqual(providerOne < providerTwo, "One" < "Two")
    }

}
