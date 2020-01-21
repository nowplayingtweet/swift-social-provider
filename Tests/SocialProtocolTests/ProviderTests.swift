import XCTest
@testable import SocialProtocol

final class ProviderTests: XCTestCase {

    static var allTests = [
        ("testProviderComparable", testProviderComparable),
        ("testStringDescribing", testStringDescribing),
    ]

    func testProviderComparable() {
        let providerOne = Provider(rawValue: "One")
        let providerTwo = Provider(rawValue: "Two")
        XCTAssertEqual(providerOne < providerTwo, "One" < "Two")
    }

    func testStringDescribing() {
        let provider = Provider(rawValue: "TestProvider")
        XCTAssertEqual(provider.rawValue, "TestProvider")
        XCTAssertEqual(String(describing: provider), "TestProvider")
    }

}
