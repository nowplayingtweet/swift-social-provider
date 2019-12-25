/**
 *  D14nClient.swift
 *  swift-social-provider
 *
 *  © 2019 kPherox.
**/

import Foundation

public protocol D14nClient: Client {

    typealias RegisterSuccess = (String, String) -> Void

}
