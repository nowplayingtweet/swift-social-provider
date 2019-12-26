/**
 *  AuthorizeByCallback.swift
 *  swift-social-provider
 *
 *  © 2019 kPherox.
**/

import Foundation

public protocol AuthorizeByCallback {

    static func handleCallback(_: NSAppleEventDescriptor)

    static func authorize(key: String, secret: String, redirectUri: String, success: @escaping Client.TokenSuccess, failure: Client.Failure?)

}

public extension AuthorizeByCallback {

    static func authorize(key: String, secret: String, redirectUri: String, success: @escaping Client.TokenSuccess) {
        Self.authorize(key: key, secret: secret, redirectUri: redirectUri, success: success, failure: nil)
    }

}
