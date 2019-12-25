/**
 *  Provider.swift
 *  swift-social-provider
 *
 *  © 2019 kPherox.
**/

import Foundation

public struct Provider: RawRepresentable, Equatable, Hashable, Comparable {

    public static func < (lhs: Provider, rhs: Provider) -> Bool {
        return lhs.rawValue < rhs.rawValue
    }

    public var rawValue: String

    public init(rawValue: String) {
        self.rawValue = rawValue
    }

}
