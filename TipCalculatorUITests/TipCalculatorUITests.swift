//
//  TipCalculatorUITests.swift
//  TipCalculatorUITests
//
//  Created by DiOS on 06.08.2023.
//

import XCTest

final class TipCalculatorUITests: XCTestCase {

    private var app: XCUIApplication!
    
    private var screen: CalculatorScreen {
        CalculatorScreen(app: app)
    }
    
    override func setUp() {
        super.setUp()
        app = .init()
        app.launch()
    }
    
    override func tearDown() {
        super.tearDown()
        app = nil
    }
    
    func testResultViewDefaultValues() {
        XCTAssertEqual(screen.amountPerPersonValueLabel.label, "0 $")
        XCTAssertEqual(screen.totalBillValueLabel.label, "0 $")
        XCTAssertEqual(screen.totalTipValueLabel.label, "0 $")
    }
}
