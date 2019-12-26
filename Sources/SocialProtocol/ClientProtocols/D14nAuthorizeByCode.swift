/**
 *  D14nAuthorizeByCode.swift
 *  swift-social-provider
 *
 *  © 2019 kPherox.
**/

import Foundation

public protocol D14nAuthorizeByCode {

    static func authorize(base: String, key: String, secret: String, failure: Client.Failure?)

    static func requestToken(base: String, key: String, secret: String, code: String, success: @escaping Client.TokenSuccess, failure: Client.Failure?)

}

public extension D14nAuthorizeByCode {

    static func authorize(base: String, key: String, secret: String) {
        Self.authorize(base: base, key: key, secret: secret, failure: nil)
    }

    static func requestToken(base: String, key: String, secret: String, code: String, success: @escaping Client.TokenSuccess) {
        Self.requestToken(base: base, key: key, secret: secret, code: code, success: success, failure: nil)
    }

}
