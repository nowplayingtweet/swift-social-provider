import XCTest
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif
@testable import HTTPExtension

final class URLRequestExtensionTests: XCTestCase {

    static var allTests = [
        ("testURLRequestGet", testURLRequestGet),
        ("testURLRequestPost", testURLRequestPost),
    ]

    func testURLRequestGet() {
        let urlRequest = URLRequest.get(url: "https://url.test", headers: [
            ("Authorization", "2357"),
            ("Accept", "application/activity+json"),
            ("Accept", "application/ld+json"),
        ])
        XCTAssertNil(URLRequest.get(url: ""))
        XCTAssertEqual(urlRequest?.httpMethod, "GET")
        XCTAssertEqual(urlRequest?.value(forHTTPHeaderField: "Accept"), "application/activity+json,application/ld+json")
    }

    func testURLRequestPost() {
        let urlRequest = URLRequest.post(url: "https://url.test", headers: [
            ("Authorization", "2357"),
            ("Accept", "application/activity+json"),
            ("Accept", "application/ld+json"),
        ])
        XCTAssertNil(URLRequest.post(url: ""))
        XCTAssertEqual(urlRequest?.httpMethod, "POST")
        XCTAssertEqual(urlRequest?.value(forHTTPHeaderField: "Authorization"), "2357")
        XCTAssertEqual(urlRequest?.value(forHTTPHeaderField: "Accept"), "application/activity+json,application/ld+json")
    }

}
