//
//  TipCalculatorUITests.swift
//  TipCalculatorUITests
//
//  Created by DiOS on 06.08.2023.
//

import XCTest

final class TipCalculatorUITests: XCTestCase {
    
    private var app: XCUIApplication!
    
    let nbsp = "\u{00A0}"
    
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
        XCTAssertEqual(screen.totalAmountPerPersonValueLabel.label, "0 $")
        XCTAssertEqual(screen.totalBillValueLabel.label, "0 $")
        XCTAssertEqual(screen.totalTipValueLabel.label, "0 $")
    }
    
    func testRegularTip() {
        // User enters a $100 bill
        screen.enterBill(amount: 100)
        XCTAssertEqual(screen.totalAmountPerPersonValueLabel.label, "100\(nbsp)$")
        XCTAssertEqual(screen.totalBillValueLabel.label, "100\(nbsp)$")
        XCTAssertEqual(screen.totalTipValueLabel.label, "0\(nbsp)$")
        
        // User selects 10%
        screen.selectTip(tip: .tenPercent)
        XCTAssertEqual(screen.totalAmountPerPersonValueLabel.label, "110\(nbsp)$")
        XCTAssertEqual(screen.totalBillValueLabel.label, "110\(nbsp)$")
        XCTAssertEqual(screen.totalTipValueLabel.label, "10\(nbsp)$")

        // User selects 15%
        screen.selectTip(tip: .fifteenPercent)
        XCTAssertEqual(screen.totalAmountPerPersonValueLabel.label, "115\(nbsp)$")
        XCTAssertEqual(screen.totalBillValueLabel.label, "115\(nbsp)$")
        XCTAssertEqual(screen.totalTipValueLabel.label, "15\(nbsp)$")

        // User selects 20%
        screen.selectTip(tip: .twentyPercent)
        XCTAssertEqual(screen.totalAmountPerPersonValueLabel.label, "120\(nbsp)$")
        XCTAssertEqual(screen.totalBillValueLabel.label, "120\(nbsp)$")
        XCTAssertEqual(screen.totalTipValueLabel.label, "20\(nbsp)$")

        // User splits the bill by 4
        screen.selectIncrementButton(numberOfTaps: 3)
        XCTAssertEqual(screen.totalAmountPerPersonValueLabel.label, "30\(nbsp)$")
        XCTAssertEqual(screen.totalBillValueLabel.label, "120\(nbsp)$")
        XCTAssertEqual(screen.totalTipValueLabel.label, "20\(nbsp)$")

        // User splits the bill by 2
        screen.selectDecrementButton(numberOfTaps: 2)
        XCTAssertEqual(screen.totalAmountPerPersonValueLabel.label, "60\(nbsp)$")
        XCTAssertEqual(screen.totalBillValueLabel.label, "120\(nbsp)$")
        XCTAssertEqual(screen.totalTipValueLabel.label, "20\(nbsp)$")
    }
    
    func testCustomTipAndSplitBillBy2() {
        screen.enterBill(amount: 300)
        screen.selectTip(tip: .custom(value: 200))
        screen.selectIncrementButton(numberOfTaps: 1)
        XCTAssertEqual(screen.totalBillValueLabel.label, "500\(nbsp)$")
        XCTAssertEqual(screen.totalTipValueLabel.label, "200\(nbsp)$")
        XCTAssertEqual(screen.totalAmountPerPersonValueLabel.label, "250\(nbsp)$")
    }
    
    func testResetButton() {
        screen.enterBill(amount: 300)
        screen.selectTip(tip: .custom(value: 200))
        screen.selectIncrementButton(numberOfTaps: 1)
        screen.doubleTapLogoView()
        XCTAssertEqual(screen.totalBillValueLabel.label, "0\(nbsp)$")
        XCTAssertEqual(screen.totalTipValueLabel.label, "0\(nbsp)$")
        XCTAssertEqual(screen.totalAmountPerPersonValueLabel.label, "0\(nbsp)$")
        XCTAssertEqual(screen.billInputViewTextField.label, "")
        XCTAssertEqual(screen.splitValueLabel.label, "1")
        XCTAssertEqual(screen.customTipButton.label, "Custom tip")
    }
}
