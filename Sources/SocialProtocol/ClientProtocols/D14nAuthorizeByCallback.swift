/**
 *  D14nAuthorizeByCallback.swift
 *  swift-social-provider
 *
 *  © 2019 kPherox.
**/

import Foundation

public protocol D14nAuthorizeByCallback {

    static func handleCallback(_: NSAppleEventDescriptor)

    static func authorize(base: String, key: String, secret: String, redirectUri: String, success: @escaping Client.TokenSuccess, failure: Client.Failure?)

}

public extension D14nAuthorizeByCallback {

    static func authorize(base: String, key: String, secret: String, redirectUri: String, success: @escaping Client.TokenSuccess) {
        Self.authorize(base: base, key: key, secret: secret, redirectUri: redirectUri, success: success, failure: nil)
    }

}
