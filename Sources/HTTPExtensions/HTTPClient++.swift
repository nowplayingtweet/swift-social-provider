/**
 *  HTTPClient++.swift
 *  NowPlayingTweet
 *
 *  © 2019 kPherox.
**/

import Foundation
import AsyncHTTPClient
import NIO
import NIOHTTP1

public extension HTTPClient {

    func get(url: String, headers: [(String, String)] = [], deadline: NIODeadline? = nil) -> EventLoopFuture<Response> {
        do {
            let request = try Request(url: url, method: .GET, headers: HTTPHeaders(headers))
            return self.execute(request: request, deadline: deadline)
        } catch {
            return self.eventLoopGroup.next().makeFailedFuture(error)
        }
    }

    func post(url: String, headers: [(String, String)] = [], body: Body? = nil, deadline: NIODeadline? = nil) -> EventLoopFuture<Response> {
        do {
            let request = try Request(url: url, method: .POST, headers: HTTPHeaders(headers), body: body)
            return self.execute(request: request, deadline: deadline)
        } catch {
            return self.eventLoopGroup.next().makeFailedFuture(error)
        }
    }

}
