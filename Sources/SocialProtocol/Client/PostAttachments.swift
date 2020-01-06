/**
 *  PostAttachments.swift
 *  swift-social-provider
 *
 *  © 2019 kPherox.
**/

import Foundation

public protocol PostAttachments {

    func post(text: String, image: Data?, otherParams: [(String, String)], success: Client.Success?, failure: Client.Failure?)

}
