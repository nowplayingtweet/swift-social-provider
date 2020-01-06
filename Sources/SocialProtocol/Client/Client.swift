/**
 *  Client.swift
 *  swift-social-provider
 *
 *  © 2019 kPherox.
**/

import Foundation

public protocol Client {

    typealias Success = () -> Void
    typealias TokenSuccess = (Credentials) -> Void
    typealias AccountSuccess = (Account) -> Void
    typealias Failure = (Error) -> Void

    var credentials: Credentials? { get }
    var userAgent: String? { get set }

    init?(_: Credentials, userAgent: String?)

    func revoke(success: Success?, failure: Failure?)

    func verify(success: @escaping AccountSuccess, failure: Failure?)

    func post(text: String, otherParams: [(String, String)], success: Success?, failure: Failure?)

}

public extension Client {

    init?(_ credentials: Credentials) {
        self.init(credentials, userAgent: nil)
    }

}
