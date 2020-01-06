/**
 *  C12nAuthorization.swift
 *  swift-social-provider
 *
 *  © 2019 kPherox.
**/

import Foundation

public protocol C12nAuthorization {

    var key: String { get }
    var secret: String { get }

    init(key: String, secret: String)

}

public extension C12nAuthorization where Self: Client {

    init(key: String, secret: String, userAgent: String?) {
        self.init(key: key, secret: secret)
        self.userAgent = userAgent
    }

}
