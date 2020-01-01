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

    var credentials: Credentials { get }
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

    func revoke() {
        self.revoke(success: nil, failure: nil)
    }

    func verify(success: @escaping AccountSuccess) {
        self.verify(success: success, failure: nil)
    }

    func post(text: String, success: Success? = nil, failure: Failure? = nil) {
        self.post(text: text, otherParams: [], success: success, failure: failure)
    }

}
