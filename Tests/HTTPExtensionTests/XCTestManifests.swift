import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(DictionaryExtensionTests.allTests),
        testCase(LocalizedErrorTests.allTests),
        testCase(StringExtensionTests.allTests),
    ]
}
#endif
