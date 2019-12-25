/**
 *  Credentials.swift
 *  swift-social-provider
 *
 *  © 2019 kPherox.
**/

import Foundation

public protocol Credentials {

    static var oauthVersion: OAuth { get }

    var apiKey: String { get }
    var apiSecret: String { get }

}
