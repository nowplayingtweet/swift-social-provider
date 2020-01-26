/**
 *  MastodonClient.swift
 *  swift-social-provider
 *
 *  © 2019 kPherox.
**/

import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

import SocialProtocol
import HTTPExtension

public class MastodonClient: Client, D14nAuthorization, AuthorizeByCallback, AuthorizeByCode, PostAttachments {

    private struct RegisterApp: Codable {
        let id: String
        let secret: String

        enum CodingKeys: String, CodingKey {
            case id = "client_id"
            case secret = "client_secret"
        }
    }

    private struct Authorization: Codable {
        let token: String

        enum CodingKeys: String, CodingKey {
            case token = "access_token"
        }
    }

    private struct Account: Codable {
        let id: String
        let name: String
        let username: String
        let avaterURL: String

        enum CodingKeys: String, CodingKey {
            case id = "id"
            case name = "display_name"
            case username = "username"
            case avaterURL = "avatar"
        }
    }

    private struct Media: Codable {
        let id: String
    }

    static var callbackObserver: NSObjectProtocol?

    public static func handleCallback(_ url: URL) {
        NotificationQueue.default.enqueue(.init(name: .callbackMastodon,
                                                object: nil,
                                                userInfo: ["url" : url]),
                                          postingStyle: .asap)
    }

    public static func registerApp(base: String, name: String, redirectUri: String, success: @escaping D14nAuthorization.RegisterSuccess, failure: Client.Failure?) {
        self.registerApp(HTTPClient.shared, base: base, name: name, redirectUri: redirectUri, success: success, failure: failure)
    }

    static func registerApp(_ client: HTTPClientProtocol, base: String, name: String, redirectUri: String, success: @escaping D14nAuthorization.RegisterSuccess, failure: Client.Failure?) {
        if !base.isHTTPString {
            failure?(SocialError.invalidURL(string: base))
            return
        }

        let requestParams: [(String, Any)] = [
            ("client_name", name),
            ("redirect_uris", redirectUri),
            ("scopes", "read write"),
        ]

        client.post(url: "\(base)/api/v1/apps", headers: [
            ("User-Agent", "Swift Social Media Provider"),
            ("Content-Type", "application/x-www-form-urlencoded"),
        ], body: requestParams.urlencoded.data(using: .utf8)) { data, response, error in
            if let error = error {
                failure?(error)
                return
            }

            guard let data = data
                , let response = response as? HTTPURLResponse else {
                    failure?(SocialError.failedAuthorize("Invalid response."))
                    return
            }

            if response.statusCode != 200 {
                failure?(SocialError.failedAuthorize(String(describing: response.statusCode)))
                return
            }

            guard let client = try? JSONDecoder().decode(RegisterApp.self, from: data) else {
                    failure?(SocialError.failedAuthorize("Invalid response."))
                    return
            }

            success(client.id, client.secret)
        }
    }

    private static func authorizeURL(base: String, key: String, secret: String, redirectUri: String) -> URL {
        let queryParams: [(String, Any)] = [
            ("client_id", key),
            ("client_secret", secret),
            ("redirect_uri", redirectUri),
            ("scopes", "read write"),
            ("response_type", "code"),
        ]
        let query: String = queryParams.urlencoded

        return URL(string: "\(base)/oauth/authorize?\(query)")!
    }

    var client: HTTPClientProtocol

    public var base: String
    public var key: String
    public var secret: String

    public var credentials: Credentials?
    public var userAgent: String?

    private var mastodonCredentials: MastodonCredentials? {
        return self.credentials as? MastodonCredentials
    }

    required public init?(_ credentials: Credentials, userAgent: String?) {
        guard let credentials = credentials as? MastodonCredentials else {
            return nil
        }

        if !credentials.base.isHTTPString {
            return nil
        }

        self.base = credentials.base
        self.key = credentials.apiKey
        self.secret = credentials.apiSecret

        self.credentials = credentials
        self.userAgent = userAgent

        self.client = HTTPClient.shared
    }

    convenience init?(_ credentials: Credentials, userAgent: String?, httpClient: HTTPClientProtocol) {
        self.init(credentials, userAgent: userAgent)

        self.client = httpClient
    }

    required public init?(base: String, key: String, secret: String) {
        if !base.isHTTPString {
            return nil
        }

        self.base = base
        self.key = key
        self.secret = secret

        self.client = HTTPClient.shared
    }

    convenience init?(base: String, key: String, secret: String, httpClient: HTTPClientProtocol) {
        self.init(base: base, key: key, secret: secret)

        self.client = httpClient
    }

    private func authorization(redirectUri: String, code: String, success: @escaping Client.TokenSuccess, failure: Client.Failure?) {
        let requestParams: [(String, Any)] = [
            ("client_id", key),
            ("client_secret", secret),
            ("redirect_uri", redirectUri),
            ("scopes", "read write"),
            ("code", code),
            ("grant_type", "authorization_code"),
        ]

        self.client.post(url: "\(base)/oauth/token", headers: [
            ("User-Agent", "Swift Social Media Provider"),
            ("Content-Type", "application/x-www-form-urlencoded"),
        ], body: requestParams.urlencoded.data(using: .utf8)) { data, response, error in
            if let error = error {
                failure?(error)
                return
            }

            guard let data = data
                , let response = response as? HTTPURLResponse else {
                    failure?(SocialError.failedAuthorize("Invalid response."))
                    return
            }

            if response.statusCode != 200 {
                failure?(SocialError.failedAuthorize(String(describing: response.statusCode)))
                return
            }

            guard let oauth = try? JSONDecoder().decode(Authorization.self, from: data) else {
                failure?(SocialError.failedAuthorize("Invalid response."))
                return
            }

            let credentials = MastodonCredentials(base: self.base, apiKey: self.key, apiSecret: self.secret, oauthToken: oauth.token)
            self.credentials = credentials
            success(credentials)
        }
    }

    public func authorize(redirectUri: String, openURL: @escaping (URL) -> Void, success: @escaping Client.TokenSuccess, failure: Client.Failure?) {
        Self.callbackObserver = NotificationCenter.default.addObserver(forName: .callbackMastodon, object: nil, queue: nil) { notification in
            guard let callbackUri = URL(string: redirectUri)
                , let url = notification.userInfo?["url"] as? URL
                , callbackUri.scheme == url.scheme && callbackUri.path == url.path
                , let code = url.query?.queryParamComponents["code"] else {
                return
            }

            self.authorization(redirectUri: redirectUri, code: code, success: { credentials in
                defer {
                    NotificationCenter.default.removeObserver(Self.callbackObserver!)
                }

                success(credentials)
            }, failure: failure)
        }

        openURL(Self.authorizeURL(base: base, key: key, secret: secret, redirectUri: redirectUri))
    }

    public func authorize(openURL: @escaping (URL) -> Void, failure: Client.Failure?) {
        openURL(Self.authorizeURL(base: base, key: key, secret: secret, redirectUri: "urn:ietf:wg:oauth:2.0:oob"))
    }

    public func requestToken(code: String, success: @escaping Client.TokenSuccess, failure: Client.Failure?) {
        self.authorization(redirectUri: "urn:ietf:wg:oauth:2.0:oob", code: code, success: success, failure: failure)
    }

    public func revoke(success: Client.Success?, failure: Client.Failure?) {
        failure?(SocialError.notImplements(className: NSStringFromClass(type(of: self)), function: #function))
    }

    public func verify(success: @escaping Client.AccountSuccess, failure: Client.Failure?) {
        guard let credentials = self.mastodonCredentials
            , let domain = URL(string: credentials.base)?.host else {
            failure?(SocialError.failedVerify("Invalid token."))
            return
        }

        self.client.get(url: "\(credentials.base)/api/v1/accounts/verify_credentials", headers: [
            ("User-Agent", self.userAgent ?? "Swift Social Media Provider"),
            ("Authorization", "Bearer \(credentials.oauthToken)"),
        ]) { data, response, error in
            if let error = error {
                failure?(error)
                return
            }

            guard let data = data
                , let response = response as? HTTPURLResponse else {
                    failure?(SocialError.failedVerify("Invalid response."))
                    return
            }

            if response.statusCode != 200 {
                failure?(SocialError.failedVerify(String(describing: response.statusCode)))
                return
            }

            guard let account = try? JSONDecoder().decode(Account.self, from: data) else {
                    failure?(SocialError.failedVerify("Invalid response."))
                    return
            }

            success(MastodonAccount(id: account.id, domain: domain, name: account.name, username: account.username, avaterUrl: URL(string: account.avaterURL)!))
        }
    }

    public func post(text: String, otherParams: [(String, String)], success: Client.Success?, failure: Client.Failure?) {
        guard let credentials = self.mastodonCredentials else {
            failure?(SocialError.failedPost("Invalid token."))
            return
        }

        var requestParams: [(String, Any)] = [
            ("status", text),
        ]

        if !otherParams.isEmpty {
            requestParams += otherParams
        }

        self.client.post(url: "\(credentials.base)/api/v1/statuses", headers: [
            ("User-Agent", self.userAgent ?? "Swift Social Media Provider"),
            ("Authorization", "Bearer \(credentials.oauthToken)"),
            ("Content-Type", "application/x-www-form-urlencoded"),
        ], body: requestParams.urlencoded.data(using: .utf8)) { data, response, error in
            if let error = error {
                failure?(error)
                return
            }

            guard let response = response as? HTTPURLResponse else {
                failure?(SocialError.failedPost("Invalid response."))
                return
            }

            if response.statusCode != 200 {
                failure?(SocialError.failedPost(String(describing: response.statusCode)))
                return
            }

            success?()
        }
    }

    public func post(text: String, image: Data?, otherParams: [(String, String)], success: Client.Success?, failure: Client.Failure?) {
        guard let image = image else {
            self.post(text: text, otherParams: otherParams, success: success, failure: failure)
            return
        }

        guard let credentials = self.mastodonCredentials else {
            failure?(SocialError.failedPost("Invalid token."))
            return
        }

        let boundary = "---------------------------\(UUID().uuidString)"

        let requestBody: [(String, Any)] = [
            ("file", image),
        ]
        let multipartData = requestBody.multipartData(boundary: boundary)

        self.client.post(url: "\(credentials.base)/api/v1/media", headers: [
            ("User-Agent", self.userAgent ?? "Swift Social Media Provider"),
            ("Authorization", "Bearer \(credentials.oauthToken)"),
            ("Content-Type", "multipart/form-data; boundary=\(boundary)"),
        ], body: multipartData) { data, response, error in
            if let error = error {
                failure?(error)
                return
            }

            guard let data = data
                , let response = response as? HTTPURLResponse else {
                    failure?(SocialError.failedPost("Invalid response."))
                    return
            }

            if response.statusCode != 200 {
                failure?(SocialError.failedPost(String(describing: response.statusCode)))
                return
            }

            guard let media = try? JSONDecoder().decode(Media.self, from: data) else {
                    failure?(SocialError.failedPost("Invalid response."))
                    return
            }

            self.post(text: text, otherParams: otherParams + [("media_ids[]", media.id)], success: success, failure: failure)
        }
    }

}
