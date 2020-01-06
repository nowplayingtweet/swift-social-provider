/**
 *  AuthorizeByCallback.swift
 *  swift-social-provider
 *
 *  © 2019 kPherox.
**/

import Foundation

public protocol AuthorizeByCallback {

    static func handleCallback(_: NSAppleEventDescriptor)

    func authorize(redirectUri: String, success: @escaping Client.TokenSuccess, failure: Client.Failure?)

}

public extension AuthorizeByCallback {

    func authorize(redirectUri: String, success: @escaping Client.TokenSuccess) {
        self.authorize(redirectUri: redirectUri, success: success, failure: nil)
    }

}
