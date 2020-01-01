import XCTest
@testable import HTTPExtension

final class URLRequestExtensionTests: XCTestCase {

    static var allTests = [
        ("Test URLRequest.get", testURLRequestGet),
        ("Test URLRequest.post", testURLRequestPost),
    ]

    func testURLRequestGet() {
        let urlRequest = URLRequest.get(url: "https://url.test")
        XCTAssertEqual(urlRequest?.httpMethod, "GET")
    }

    func testURLRequestPost() {
        let urlRequest = URLRequest.post(url: "https://url.test")
        XCTAssertEqual(urlRequest?.httpMethod, "POST")
    }

}
