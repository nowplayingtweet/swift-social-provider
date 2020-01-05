import XCTest
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
    let apiKey: String = ""
    let apiSecret: String = ""
    let oauthToken: String = ""
    let oauthSecret: String = ""
}

struct TestOAuth2Credentials: Credentials, OAuth2 {
    let apiKey: String = ""
    let apiSecret: String = ""
    let oauthToken: String = ""
}
