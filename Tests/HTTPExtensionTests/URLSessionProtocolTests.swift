import XCTest
@testable import HTTPExtension

#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

final class URLSessionProtocolTests: XCTestCase {

    static var allTests = [
        ("testURLSessionImplementProtocol",testURLSessionImplementProtocol),
    ]

    func testURLSessionImplementProtocol() {
        let dataTask = (URLSession.shared as URLSessionProtocol).dataTask(with: URLRequest(url: URL(string: "https://social.test")!), completionHandler: { _,_,_ in })
        XCTAssertNotNil(dataTask as? URLSessionDataTask)
        dataTask.cancel()
    }

}
