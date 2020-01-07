/**
 *  MastodonAccount.swift
 *  swift-social-provider
 *
 *  © 2019 kPherox.
**/

import Foundation
import SocialProtocol

struct MastodonAccount: D14nAccount, Equatable {

    static let provider = Provider.Mastodon

    let id: String
    let domain: String
    let name: String
    let username: String
    let avaterUrl: URL

}
