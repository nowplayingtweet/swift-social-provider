/**
 *  OAuth1.swift
 *  swift-social-provider
 *
 *  © 2019 kPherox.
**/

import Foundation

public protocol OAuth1 {

    var oauthToken: String { get }
    var oauthSecret: String { get }

}

public extension OAuth1 where Self: Credentials {

    static var oauthVersion: OAuth {
        return .One
    }

}
