import XCTest
@testable import HTTPExtension

#if canImport(FoundationNetworking)
import FoundationNetworking
#endif
import SocialProtocol

private class DataTaskMock: URLSessionDataTaskProtocol {
    private(set) var wasCalled = false
    var request: URLRequest?
    var handler: ((Data?, URLResponse?, Error?) -> Void)?

    func queue(_ request: URLRequest, _ handler: @escaping (Data?, URLResponse?, Error?) -> Void) {
        self.request = request
        self.handler = handler
    }

    func resume() {
        guard let request = self.request else { return }
        self.wasCalled = true

        self.handler?(nil, HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: "http/1.1", headerFields: nil), nil)
    }

    func cancel() {
        self.handler?(nil, nil, URLError(URLError.cancelled))
    }
}

private class URLSessionMock: URLSessionProtocol {
    let taskMock: DataTaskMock

    init(taskMock: DataTaskMock = DataTaskMock()) {
        self.taskMock = taskMock
    }

    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTaskProtocol {
        self.taskMock.queue(request, completionHandler)
        return self.taskMock
    }
}

final class HTTPClientTests: XCTestCase {

    static var allTests = [
        ("testHTTPClientGet", testHTTPClientGet),
        ("testHTTPClientPost", testHTTPClientPost),
    ]

    func testHTTPClientGet() {
        let session = URLSessionMock()
        let client = HTTPClient(session)

        client.get(url: "") { _, _, error in
            XCTAssertEqual(error?.localizedDescription, SocialError.invalidURL(string: "").localizedDescription)
        }

        client.get(url: "https://url.test", headers: [
            ("Accept", "application/activity+json"),
            ("Accept", "application/ld+json"),
        ]) { _,_,_ in
            XCTAssertEqual(session.taskMock.request?.httpMethod, "GET")
            XCTAssertEqual(session.taskMock.request?.value(forHTTPHeaderField: "Accept"), "application/activity+json,application/ld+json")
        }
    }

    func testHTTPClientPost() {
        let session = URLSessionMock()
        let client = HTTPClient(session)

        client.post(url: "") { _, _, error in
            XCTAssertEqual(error?.localizedDescription, SocialError.invalidURL(string: "").localizedDescription)
        }

        client.post(url: "https://url.test", headers: [
            ("Authorization", "2357"),
            ("Accept", "application/activity+json"),
            ("Accept", "application/ld+json"),
        ]) { _,_,_ in
            XCTAssertEqual(session.taskMock.request?.httpMethod, "POST")
            XCTAssertEqual(session.taskMock.request?.value(forHTTPHeaderField: "Authorization"), "2357")
            XCTAssertEqual(session.taskMock.request?.value(forHTTPHeaderField: "Accept"), "application/activity+json,application/ld+json")
        }
    }

}
