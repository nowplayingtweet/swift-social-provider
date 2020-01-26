import XCTest

import SocialProtocolTests
import HTTPExtensionTests
import MastodonProviderTests

var tests = [XCTestCaseEntry]()
tests += SocialProtocolTests.allTests()
tests += HTTPExtensionTests.allTests()
tests += MastodonProviderTests.allTests()
XCTMain(tests)
