import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(AccountTests.allTests),
        testCase(CredentialsTests.allTests),
        testCase(ProviderTests.allTests),
        testCase(SocialErrorTests.allTests),
    ]
}
#endif
