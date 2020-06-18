import XCTest

import Kanna

@testable import AtCoderYourData

final class AtCoderYourDataTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        //XCTAssertEqual(AtCoderYourData().main(), "Hello, World!")
    }
    func historyTest() {
        if let history = try? History(userId: "AgeashiParrot") {
            print(history.rows!)
            print(history.columns!)
        }
    }

    static var allTests = [
        ("historyTest", historyTest)
    ]
}
