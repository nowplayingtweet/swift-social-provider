/**
 *  SocialError.swift
 *  swift-social-provider
 *
 *  © 2018 kPherox.
**/

import Foundation

public enum SocialError: Error {

    case FailedAuthorize(String)
    case FailedRevoke(String)
    case FailedVerify(String)
    case FailedPost(String)
    case NotImplements(className: String, function: String)

}

extension SocialError: LocalizedError {

    public var errorDescription: String? {
        switch self {
        case .NotImplements(let className, let function):
            return "Not implements \(className).\(function)"
        case .FailedAuthorize(let message):
            return "failed authorize: \(message)"
        case .FailedRevoke(let message):
            return "failed revoke: \(message)"
        case .FailedVerify(let message):
            return "failed verify: \(message)"
        case .FailedPost(let message):
            return "failed post: \(message)"
        }
    }

}
