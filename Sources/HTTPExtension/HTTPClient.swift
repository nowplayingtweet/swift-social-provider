/**
 *  HTTPClient.swift
 *  swift-social-provider
 *
 *  © 2019 kPherox.
**/

import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

import SocialProtocol

public protocol HTTPClientProtocol {
    func get(url: String, headers: [(String, String)], completionHandler: @escaping (Data?, HTTPURLResponse?, Error?) -> Void) -> Void
    func post(url: String, headers: [(String, String)], body: Data?, completionHandler: @escaping (Data?, HTTPURLResponse?, Error?) -> Void) -> Void
}

public class HTTPClient: HTTPClientProtocol {

    public static let shared: HTTPClient = HTTPClient(URLSession.shared)

    var session: URLSessionProtocol

    init(_ session: URLSessionProtocol) {
        self.session = session
    }

    public func get(url urlString: String, headers: [(String, String)] = [], completionHandler: @escaping (Data?, HTTPURLResponse?, Error?) -> Void) {
        guard let url = URL(string: urlString) else {
            completionHandler(nil, nil, SocialError.invalidURL(string: urlString))
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        headers.forEach { (key, value) in
            if request.value(forHTTPHeaderField: key) != nil {
                request.addValue(value, forHTTPHeaderField: key)
            } else {
                request.setValue(value, forHTTPHeaderField: key)
            }
        }

        self.session.dataTask(with: request, completionHandler: { completionHandler($0, $1 as? HTTPURLResponse, $2) }).resume()
        return
    }

    public func post(url urlString: String, headers: [(String, String)] = [], body: Data? = nil, completionHandler: @escaping (Data?, HTTPURLResponse?, Error?) -> Void) {
        guard let url = URL(string: urlString) else {
            completionHandler(nil, nil, SocialError.invalidURL(string: urlString))
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        headers.forEach { (key, value) in
            if request.value(forHTTPHeaderField: key) != nil {
                request.addValue(value, forHTTPHeaderField: key)
            } else {
                request.setValue(value, forHTTPHeaderField: key)
            }
        }

        self.session.dataTask(with: request, completionHandler: { completionHandler($0, $1 as? HTTPURLResponse, $2) }).resume()
        return
    }

}
