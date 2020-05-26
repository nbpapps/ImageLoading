import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(ImageLoadingTests.allTests),
        testCase(RunningTasksCacheTests.allTests),

    ]
}
#endif
