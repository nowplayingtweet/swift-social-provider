import XCTest
@testable import MastodonProvider

final class MastodonClientTests: XCTestCase {

    static var allTests = [
        ("testHandleCallback", testHandleCallback),
    ]

    func testHandleCallback() {
        let event = NSAppleEventDescriptor(eventClass: .init(kInternetEventClass), eventID: .init(kAEGetURL), targetDescriptor: nil, returnID: .zero, transactionID: .zero)
        event.setParam(.init(string: "https://social.test/url"), forKeyword: .init(keyDirectObject))
        NotificationCenter.default.addObserver(forName: .callbackMastodon, object: nil, queue: nil) { notification in
            XCTAssertEqual(notification.userInfo?["url"] as? URL, URL(string: "https://social.test/url"))
        }
        MastodonClient.handleCallback(event)
    }

}
