import XCTest
@testable import HTTPExtension

import NIO
import AsyncHTTPClient

final class LocalizedErrorTests: XCTestCase {

    static var allTests = [
        ("Test HTTPClientError.localizedDescription", testHTTPClientErrorLocalizedDescription),
        ("Test EventLoopError.localizedDescription", testEventLoopErrorLocalizedDescription),
    ]

    func testHTTPClientErrorLocalizedDescription() {
        XCTAssertEqual(HTTPClientError.invalidURL.localizedDescription,
                       "HTTPClientError.invalidURL")
    }

    func testEventLoopErrorLocalizedDescription() {
        XCTAssertEqual(EventLoopError.shutdown.localizedDescription,
                       "EventLoopError.shutdown")
    }

}
