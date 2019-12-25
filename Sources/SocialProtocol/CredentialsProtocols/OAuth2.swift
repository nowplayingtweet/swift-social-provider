/**
 *  OAuth2.swift
 *  swift-social-provider
 *
 *  © 2019 kPherox.
**/

import Foundation

public protocol OAuth2 {

    var oauthToken: String { get }

}

public extension OAuth2 where Self: Credentials {

    static var oauthVersion: OAuth {
        return .Two
    }

}
