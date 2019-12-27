/**
 *  D14nClient.swift
 *  swift-social-provider
 *
 *  © 2019 kPherox.
**/

import Foundation

public protocol D14nClient: Client {

    typealias RegisterSuccess = (String, String) -> Void

    static func registerApp(base: String, name: String, redirectUri: String, success: @escaping RegisterSuccess, failure: Client.Failure?)

}

extension D14nClient {

    static func registerApp(base: String, name: String, success: @escaping RegisterSuccess, failure: Client.Failure? = nil) {
        Self.registerApp(base: base, name: name, redirectUri: "urn:ietf:wg:oauth:2.0:oob", success: success, failure: failure)
    }

}
