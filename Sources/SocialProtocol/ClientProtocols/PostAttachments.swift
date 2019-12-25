/**
 *  PostAttachments.swift
 *  swift-social-provider
 *
 *  © 2019 kPherox.
**/

import Foundation

public protocol PostAttachments {

    func post(visibility: String, text: String, image: Data?, sensitive: Bool, success: Client.Success?, failure: Client.Failure?)

}

public extension PostAttachments {

    func post(text: String, image: Data?, sensitive: Bool = false, success: Client.Success? = nil, failure: Client.Failure? = nil) {
        self.post(visibility: "", text: text, image: image, sensitive: sensitive, success: success, failure: failure)
    }

}

public extension PostAttachments where Self: Client {

    func post(visibility: String, text: String, success: Client.Success?, failure: Client.Failure?) {
        self.post(visibility: visibility, text: text, image: nil, sensitive: false, success: success, failure: failure)
    }

}
