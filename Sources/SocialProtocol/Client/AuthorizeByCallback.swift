/**
 *  AuthorizeByCallback.swift
 *  swift-social-provider
 *
 *  © 2019 kPherox.
**/

import Foundation

public protocol AuthorizeByCallback {

    static func handleCallback(_: URL)

    func authorize(redirectUri: String, openURL: @escaping (URL) -> Void, success: @escaping Client.TokenSuccess, failure: Client.Failure?)

}
