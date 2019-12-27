import XCTest

import SocialProviderTests
import HTTPExtensionTests

var tests = [XCTestCaseEntry]()
tests += SocialProviderTests.allTests()
tests += HTTPExtensionTests.allTests()
XCTMain(tests)
