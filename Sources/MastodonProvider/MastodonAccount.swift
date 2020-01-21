/**
 *  MastodonAccount.swift
 *  swift-social-provider
 *
 *  © 2019 kPherox.
**/

import Foundation
import SocialProtocol

public struct MastodonAccount: D14nAccount, Equatable {

    public static let provider = Provider.Mastodon

    public let id: String
    public let domain: String
    public let name: String
    public let username: String
    public let avaterUrl: URL

}
