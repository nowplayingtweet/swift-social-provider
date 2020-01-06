/**
 *  D14nAuthorization.swift
 *  swift-social-provider
 *
 *  © 2019 kPherox.
**/

import Foundation

public protocol D14nAuthorization {

    typealias RegisterSuccess = (String, String) -> Void

    static func registerApp(base: String, name: String, redirectUri: String, success: @escaping RegisterSuccess, failure: Client.Failure?)

    var base: String { get }
    var key: String { get }
    var secret: String { get }

    init?(base: String, key: String, secret: String)

}

public extension D14nAuthorization {

    static func registerApp(base: String, name: String, success: @escaping RegisterSuccess, failure: Client.Failure? = nil) {
        Self.registerApp(base: base, name: name, redirectUri: "urn:ietf:wg:oauth:2.0:oob", success: success, failure: failure)
    }

}

public extension D14nAuthorization where Self: Client {

    init?(base: String, key: String, secret: String, userAgent: String?) {
        self.init(base: base, key: key, secret: secret)
        self.userAgent = userAgent
    }

}
