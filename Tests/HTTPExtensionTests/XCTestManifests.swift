import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(StringExtensionTests.allTests),
        testCase(TupleArrayExtensionTests.allTests),
        testCase(URLRequestExtensionTests.allTests),
    ]
}
#endif
