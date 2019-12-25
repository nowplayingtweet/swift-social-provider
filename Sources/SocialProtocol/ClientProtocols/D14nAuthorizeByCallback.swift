/**
 *  D14nAuthorizeByCallback.swift
 *  swift-social-provider
 *
 *  © 2019 kPherox.
**/

import Foundation

public protocol D14nAuthorizeByCallback: AuthorizeByCallback {

    static func registerApp(base: String, name: String, urlScheme: String, success: @escaping D14nClient.RegisterSuccess, failure: Client.Failure?)

    static func authorize(base: String, key: String, secret: String, urlScheme: String, success: @escaping Client.TokenSuccess, failure: Client.Failure?)

}

public extension D14nAuthorizeByCallback {

    static func registerApp(base: String, name: String, urlScheme: String, success: @escaping D14nClient.RegisterSuccess) {
        Self.registerApp(base: base, name: name, urlScheme: urlScheme, success: success, failure: nil)
    }

    static func authorize(base: String, key: String, secret: String, urlScheme: String, success: @escaping Client.TokenSuccess) {
        Self.authorize(base: base, key: key, secret: secret, urlScheme: urlScheme, success: success, failure: nil)
    }

    static func authorize(key: String, secret: String, urlScheme: String, success: @escaping Client.TokenSuccess, failure: Client.Failure?) {
        Self.authorize(base: "", key: key, secret: secret, urlScheme: urlScheme, success: success, failure: failure)
    }

}
