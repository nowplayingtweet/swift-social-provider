/**
 *  SocialError.swift
 *  swift-social-provider
 *
 *  © 2018 kPherox.
**/

import Foundation

public enum SocialError: Error {

    case invalidURL(string: String)
    case failedAuthorize(String)
    case failedRevoke(String)
    case failedVerify(String)
    case failedPost(String)
    case notImplements(className: String, function: String)

}

extension SocialError: LocalizedError {

    public var errorDescription: String? {
        switch self {
        case .invalidURL(let string):
            return "Invalid URL: \(string)"
        case .failedAuthorize(let message):
            return "Failed authorize: \(message)"
        case .failedRevoke(let message):
            return "Failed revoke: \(message)"
        case .failedVerify(let message):
            return "Failed verify: \(message)"
        case .failedPost(let message):
            return "Failed post: \(message)"
        case .notImplements(let className, let function):
            return "Not implements \(className).\(function)"
        }
    }

}
