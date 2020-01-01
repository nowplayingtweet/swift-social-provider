import XCTest
@testable import HTTPExtension

final class DictionaryExtensionTests: XCTestCase {

    static var allTests = [
        ("Test extension Dictionary.urlencoded", testDictionaryURLEncoded),
        ("Test extension Dictionary.multipartData", testDictionaryMultipartData),
    ]

    func testDictionaryURLEncoded() {
        XCTAssertEqual([
            "test": "one",
            "テスト": "",
        ].urlencoded, "%E3%83%86%E3%82%B9%E3%83%88=&test=one")
    }

    func testDictionaryMultipartData() {
        let imageTIFF = NSImage(named: NSImage.userGuestName)?.tiffRepresentation
        let imageData = NSBitmapImageRep(data: imageTIFF!)?.representation(using: .png, properties: [:])
        let dict: [String : Any] = [
            "test": "one",
            "integer": 21,
            "テスト": imageData!,
        ]
        let boundary = UUID().uuidString
        let boundaryPrefix = "--\(boundary)"
        let data = NSMutableData()
        data.append("\(boundaryPrefix)\r\n".data(using: .utf8, allowLossyConversion: false)!)
        data.append("Content-Disposition: form-data; name=\"test\"\r\n\r\n".data(using: .utf8, allowLossyConversion: false)!)
        data.append("one\r\n".data(using: .utf8, allowLossyConversion: false)!)
        data.append("\(boundaryPrefix)\r\n".data(using: .utf8, allowLossyConversion: false)!)
        data.append("Content-Disposition: form-data; name=\"integer\"\r\n\r\n".data(using: .utf8, allowLossyConversion: false)!)
        data.append("21\r\n".data(using: .utf8, allowLossyConversion: false)!)
        data.append("\(boundaryPrefix)\r\n".data(using: .utf8, allowLossyConversion: false)!)
        data.append("Content-Disposition: form-data; name=\"テスト\"; filename=\"media\"\r\n".data(using: .utf8, allowLossyConversion: false)!)
        data.append("Content-Type: application/octet-stream\r\n\r\n".data(using: .utf8, allowLossyConversion: false)!)
        data.append(imageData!)
        data.append("\r\n".data(using: .utf8, allowLossyConversion: false)!)
        data.append("\(boundaryPrefix)--".data(using: .utf8, allowLossyConversion: false)!)
        XCTAssertEqual(dict.multipartData(boundary: boundary), data as Data)
    }

}
