/**
 *  AuthorizeByCode.swift
 *  swift-social-provider
 *
 *  © 2019 kPherox.
**/

import Foundation

public protocol AuthorizeByCode {

    func authorize(failure: Client.Failure?)

    func requestToken(code: String, success: @escaping Client.TokenSuccess, failure: Client.Failure?)

}

public extension AuthorizeByCode {

    func authorize() {
        self.authorize(failure: nil)
    }

    func requestToken(code: String, success: @escaping Client.TokenSuccess) {
        self.requestToken(code: code, success: success, failure: nil)
    }

}
