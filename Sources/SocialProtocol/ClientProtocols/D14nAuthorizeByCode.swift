/**
 *  D14nAuthorizeByCode.swift
 *  swift-social-provider
 *
 *  © 2019 kPherox.
**/

import Foundation

public protocol D14nAuthorizeByCode: AuthorizeByCode {

    static func registerApp(base: String, name: String, success: @escaping D14nClient.RegisterSuccess, failure: Client.Failure?)

    static func authorize(base: String, key: String, secret: String, failure: Client.Failure?)

    static func requestToken(base: String, key: String, secret: String, code: String, success: @escaping Client.TokenSuccess, failure: Client.Failure?)

}

public extension D14nAuthorizeByCode {

    static func registerApp(base: String, name: String, success: @escaping D14nClient.RegisterSuccess) {
        Self.registerApp(base: base, name: name, success: success, failure: nil)
    }

    static func authorize(base: String, key: String, secret: String) {
        Self.authorize(base: base, key: key, secret: secret, failure: nil)
    }

    static func requestToken(base: String, key: String, secret: String, code: String, success: @escaping Client.TokenSuccess) {
        Self.requestToken(base: base, key: key, secret: secret, code: code, success: success, failure: nil)
    }

    static func authorize(key: String, secret: String, failure: Client.Failure?) {
        Self.authorize(base: "", key: key, secret: secret, failure: failure)
    }

    static func requestToken(key: String, secret: String, code: String, success: @escaping Client.TokenSuccess, failure: Client.Failure?) {
        Self.requestToken(base: "", key: key, secret: secret, code: code, success: success, failure: failure)
    }

}
