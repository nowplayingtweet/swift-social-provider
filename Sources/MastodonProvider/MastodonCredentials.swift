/**
 *  MastodonCredentials.swift
 *  swift-social-provider
 *
 *  © 2019 kPherox.
**/

import Foundation
import SocialProtocol

public struct MastodonCredentials: D14nCredentials, OAuth2, Codable {

    public let base: String

    public let apiKey: String
    public let apiSecret: String

    public let oauthToken: String

}
