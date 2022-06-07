//
//  CurrencyFormatterTests.swift
//  BankeyTests
//
//  Created by Vitor Trimer on 07/06/22.
//

import Foundation
import XCTest

@testable import Bankey

class Test: XCTestCase {
    var formatter: CurrencyFormatter!
    
    override func setUp() {
        super.setUp()
        formatter = CurrencyFormatter()
    }
    
    func testBreakDollarsIntoCents() throws {
        let result = formatter.breakIntoDollarsAndCents(1234.56)
        XCTAssertEqual(result.0, "1,234")
        XCTAssertEqual(result.1, "56")
    }
    
    func testDollarsFormatted() throws {
        let result = formatter.dollarsFormatted(1234)
        XCTAssertEqual(result, "$1,234.00")
    }
    
    func testZeroDollars() throws {
        let result = formatter.dollarsFormatted(00)
        XCTAssertEqual(result, "$0.00")
    }
}
