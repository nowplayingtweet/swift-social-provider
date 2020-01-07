import Foundation
@testable import SocialProtocol

struct TestAccount: Account {
    static var provider: Provider = Provider(rawValue: "Test")

    let id: String
    let name: String = "Test Account"
    let username: String = "test_account"
    let avaterUrl: URL = URL(string: "https://social.test/image.png")!
}

struct TestD14nAccount: D14nAccount {
    static var provider: Provider = Provider(rawValue: "TestD14n")

    let domain: String
    let id: String
    let name: String = "Test D14n Account"
    let username: String = "test_d14n_account"
    let avaterUrl: URL = URL(string: "https://social.test/image.png")!
}

struct TestOAuth1Credentials: Credentials, OAuth1 {
    let apiKey: String = "oauth1-key"
    let apiSecret: String = "oauth1-secret"
    let oauthToken: String = "oauth1-token"
    let oauthSecret: String = "oauth1-tokensecret"
}

struct TestOAuth2Credentials: Credentials, OAuth2 {
    let apiKey: String = "oauth2-key"
    let apiSecret: String = "oauth2-secret"
    let oauthToken: String = "oauth2-token"
}

class TestC12nClient: Client, C12nAuthorization {
    var key: String
    var secret: String

    var credentials: Credentials?
    var userAgent: String?

    required init(key: String, secret: String) {
        self.key = key
        self.secret = secret
    }

    required init?(_ credentials: Credentials, userAgent: String?) {
        self.key = credentials.apiKey
        self.secret = credentials.apiSecret

        self.credentials = credentials
        self.userAgent = userAgent
    }

    func revoke(success: Client.Success?, failure: Client.Failure?) {}

    func verify(success: @escaping Client.AccountSuccess, failure: Client.Failure?) {}

    func post(text: String, otherParams: [(String, String)], success: Client.Success?, failure: Client.Failure?) {}
}

class TestD14nClient: Client, D14nAuthorization {
    static func registerApp(base: String, name: String, redirectUri: String, success: @escaping D14nAuthorization.RegisterSuccess, failure: Client.Failure?) {}

    var base: String
    var key: String
    var secret: String

    var credentials: Credentials?
    var userAgent: String?

    required init(base: String, key: String, secret: String) {
        self.base = base
        self.key = key
        self.secret = secret
    }

    required init?(_ credentials: Credentials, userAgent: String?) {
        guard let credentials = credentials as? D14nCredentials else {
            return nil
        }
        self.base = credentials.base
        self.key = credentials.apiKey
        self.secret = credentials.apiSecret

        self.credentials = credentials
        self.userAgent = userAgent
    }

    func revoke(success: Client.Success?, failure: Client.Failure?) {}

    func verify(success: @escaping Client.AccountSuccess, failure: Client.Failure?) {}

    func post(text: String, otherParams: [(String, String)], success: Client.Success?, failure: Client.Failure?) {}
}
