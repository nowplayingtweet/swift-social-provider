import XCTest
@testable import MastodonProvider

final class MastodonClientTests: XCTestCase {

    static var allTests = [
        ("testHandleCallback", testHandleCallback),
    ]

    func testHandleCallback() {
        let url = URL(string: "https://social.test/url")!
        NotificationCenter.default.addObserver(forName: .callbackMastodon, object: nil, queue: nil) { notification in
            XCTAssertEqual(notification.userInfo?["url"] as? URL, url)
        }
        MastodonClient.handleCallback(url)
    }

}
