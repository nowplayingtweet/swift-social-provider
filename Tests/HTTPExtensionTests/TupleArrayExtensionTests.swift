import XCTest
@testable import HTTPExtension

final class TupleArrayExtensionTests: XCTestCase {

    static var allTests = [
        ("testTupleArrayURLEncoded", testTupleArrayURLEncoded),
        ("testTupleArrayMultipartData", testTupleArrayMultipartData),
    ]

    func testTupleArrayURLEncoded() {
        let formData: [(String, Any)] = [
            ("test", "one"),
            ("integer", 21),
            ("テスト", ""),
        ]
        XCTAssertEqual(formData.urlencoded, "test=one&integer=21&%E3%83%86%E3%82%B9%E3%83%88=")
    }

    func testTupleArrayMultipartData() {
        let testData = "test data".data(using: .utf8)
        let formData: [(String, Any)] = [
            ("test", "one"),
            ("integer", 21),
            ("テスト", testData!),
        ]
        let boundary = UUID().uuidString
        let boundaryPrefix = "--\(boundary)"
        let data = NSMutableData()
        data.append("\(boundaryPrefix)\r\n")
        data.append("Content-Disposition: form-data; name=\"test\"\r\n\r\n")
        data.append("one\r\n")
        data.append("\(boundaryPrefix)\r\n")
        data.append("Content-Disposition: form-data; name=\"integer\"\r\n\r\n")
        data.append("21\r\n")
        data.append("\(boundaryPrefix)\r\n")
        data.append("Content-Disposition: form-data; name=\"テスト\"; filename=\"media\"\r\n")
        data.append("Content-Type: application/octet-stream\r\n\r\n")
        data.append(testData!)
        data.append("\r\n")
        data.append("\(boundaryPrefix)--")
        XCTAssertEqual(formData.multipartData(boundary: boundary), data as Data)
    }

}

private extension NSMutableData {

    func append(_ string: String) {
        let data = string.data(using: .utf8, allowLossyConversion: false)
        self.append(data!)
    }

}
