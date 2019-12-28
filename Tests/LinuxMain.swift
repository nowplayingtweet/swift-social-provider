import XCTest

import SocialProtocolTests
import HTTPExtensionTests

var tests = [XCTestCaseEntry]()
tests += SocialProtocolTests.allTests()
tests += HTTPExtensionTests.allTests()
XCTMain(tests)
