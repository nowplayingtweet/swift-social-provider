/**
 *  String++.swift
 *  NowPlayingTweet
 *
 *  © 2019 kPherox.
**/

import Foundation

public extension String {

    var queryParamComponents: [String : String] {
        return self.components(separatedBy: "&").map({
            $0.components(separatedBy: "=").map({ $0.removingPercentEncoding! })
        }).reduce(into: [String:String]()) { dict, pair in
            if pair.count == 2 {
                dict[pair[0]] = pair[1]
            } else if pair.count == 1 {
                dict[pair[0]] = ""
            }
        }
    }

    var isHTTPString: Bool {
        let regexp = try? NSRegularExpression(pattern: "^https?://[A-Za-z0-9\\-\\.]+", options: [])

        return regexp?.firstMatch(in: self, range: NSRange(self.startIndex..., in: self)) != nil
    }

}
