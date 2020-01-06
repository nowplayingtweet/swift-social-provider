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
