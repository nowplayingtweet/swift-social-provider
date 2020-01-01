/**
 *  Dictionary++.swift
 *  NowPlayingTweet
 *
 *  © 2019 kPherox.
**/

import Foundation

public extension Array where Element == (String, Any) {

    var urlencoded: String {
        let params: [String] = self.map {
            "\($0)=\($1)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        }

        return params.joined(separator: "&")
    }

    func multipartData(boundary: String) -> Data {
        let boundaryPrefix = "--\(boundary)"
        let body = NSMutableData()

        self.forEach { key, value in
            body.append("\(boundaryPrefix)\r\n")

            switch value {
            case let data as Data:
                body.append("Content-Disposition: form-data; name=\"\(key)\"; filename=\"media\"\r\n")
                body.append("Content-Type: application/octet-stream\r\n\r\n")
                body.append(data)
            case let string as String:
                body.append("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
                body.append(string)
            default:
                body.append("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
                body.append(String(describing: value))
            }

            body.append("\r\n")
        }

        body.append("\(boundaryPrefix)--")

        return body as Data
    }

}

private extension NSMutableData {

    func append(_ string: String) {
        let data = string.data(using: .utf8, allowLossyConversion: false)
        self.append(data!)
    }

}
