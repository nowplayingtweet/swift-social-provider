/**
 *  URLRequest++.swift
 *  swift-social-provider
 *
 *  © 2019 kPherox.
**/

import Foundation

public extension URLRequest {

    static func get(url: String, headers: [(String, String)] = []) -> URLRequest? {
        guard let url = URL(string: url) else {
            return nil
        }

        var request = self.init(url: url)
        request.httpMethod = "GET"
        headers.forEach { (key, value) in
            request.setValue(value, forHTTPHeaderField: key)
        }

        return request
    }

    static func post(url: String, headers: [(String, String)] = [], body: Data? = nil) -> URLRequest? {
        guard let url = URL(string: url) else {
            return nil
        }

        var request = self.init(url: url)
        request.httpMethod = "POST"
        headers.forEach { (key, value) in
            request.setValue(value, forHTTPHeaderField: key)
        }

        return request
    }

}
