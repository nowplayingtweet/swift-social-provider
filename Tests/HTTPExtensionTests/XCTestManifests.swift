import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(HTTPClientTests.allTests),
        testCase(StringExtensionTests.allTests),
        testCase(TupleArrayExtensionTests.allTests),
        testCase(URLSessionProtocolTests.allTests),
    ]
}
#endif
