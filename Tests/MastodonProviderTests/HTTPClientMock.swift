import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

import HTTPExtension

class HTTPClientMock: HTTPClientProtocol {
    private(set) var wasCalled = false
    var statusCode: Int
    var headerFields: [String: String]?
    var responseBody: Data?
    var responseError: Error?

    init(statusCode: Int = 200, headers: [String : String]? = nil, body: Data? = nil, error: Error? = nil) {
        self.statusCode = statusCode
        self.headerFields = headers
        self.responseBody = body
        self.responseError = error
    }

    func get(url: String, headers: [(String, String)], completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
        guard let url = URL(string: url) else {
            completionHandler(nil, nil, URLError(.cancelled))
            return
        }

        if let error = self.responseError {
            completionHandler(nil, nil, error)
            return
        }

        completionHandler(self.responseBody, HTTPURLResponse(url: url, statusCode: self.statusCode, httpVersion: "http/1.1", headerFields: self.headerFields), nil)
    }

    func post(url: String, headers: [(String, String)], body: Data?, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
        guard let url = URL(string: url) else {
            completionHandler(nil, nil, URLError(.cancelled))
            return
        }

        if let error = self.responseError {
            completionHandler(nil, nil, error)
            return
        }

        completionHandler(self.responseBody, HTTPURLResponse(url: url, statusCode: self.statusCode, httpVersion: "http/1.1", headerFields: self.headerFields), nil)
    }
}
