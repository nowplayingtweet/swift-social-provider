/**
 *  D14nAccount.swift
 *  swift-social-provider
 *
 *  © 2019 kPherox.
**/

import Foundation

public protocol D14nAccount: Account {

    var domain: String { get }

}

public extension D14nAccount {

    func isEqual(_ account: Account?) -> Bool {
        guard let account = account
            , let d14nAccount = account as? D14nAccount else {
            return false
        }

        return type(of: self).provider == type(of: account).provider
            && self.id == account.id
            && self.domain == d14nAccount.domain
    }

}
