import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(LocalizedErrorTests.allTests),
    ]
}
#endif
