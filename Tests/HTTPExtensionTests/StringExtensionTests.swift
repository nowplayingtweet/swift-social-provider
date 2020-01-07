import XCTest
@testable import HTTPExtension

final class StringExtensionTests: XCTestCase {

    static var allTests = [
        ("testStringQueryParamComponents", testStringQueryParamComponents),
        ("testStringIsHTTPString", testStringIsHTTPString),
    ]

    func testStringQueryParamComponents() {
        XCTAssertEqual("test=one&empty&%E3%83%86%E3%82%B9%E3%83%88=".queryParamComponents, [
            "test": "one",
            "テスト": "",
            "empty": "",
        ])
    }

    func testStringIsHTTPString() {
        XCTAssertTrue("http://url.test".isHTTPString)
        XCTAssertTrue("https://url.test".isHTTPString)
        XCTAssertFalse("url.test".isHTTPString)
        XCTAssertFalse("wss://url.test".isHTTPString)
    }

}
