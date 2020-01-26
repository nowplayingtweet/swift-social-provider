import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(MastodonClientAuthorizeTests.allTests),
        testCase(MastodonClientInitializeTests.allTests),
        testCase(MastodonClientStaticFunctionTests.allTests),
    ]
}
#endif
