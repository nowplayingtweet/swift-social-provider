import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(MastodonClientStaticFunctionTests.allTests),
        testCase(MastodonClientInstanceTests.allTests),
    ]
}
#endif
