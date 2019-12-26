/**
 *  PostAttachments.swift
 *  swift-social-provider
 *
 *  © 2019 kPherox.
**/

import Foundation

public protocol PostAttachments {

    func post(text: String, image: Data?, otherParams: [String : String]?, success: Client.Success?, failure: Client.Failure?)

}

public extension PostAttachments {

    func post(text: String, image: Data?, success: Client.Success? = nil, failure: Client.Failure? = nil) {
        self.post(text: text, image: image, otherParams: nil, success: success, failure: failure)
    }

}
