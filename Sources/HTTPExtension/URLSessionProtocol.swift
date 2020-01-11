/**
 *  URLSessionProtocol.swift
 *  swift-social-provider
 *
 *  © 2020 kPherox.
**/

import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

protocol URLSessionDataTaskProtocol {

    func resume()
    func cancel()

}

extension URLSessionDataTask: URLSessionDataTaskProtocol {}

protocol URLSessionProtocol {

    func dataTask(with: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTaskProtocol

}

extension URLSession: URLSessionProtocol {

    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTaskProtocol {
        return self.dataTask(with: request, completionHandler: completionHandler) as URLSessionDataTask
    }

}
