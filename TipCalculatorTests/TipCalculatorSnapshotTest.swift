//
//  TipCalculatorSnapshotTest.swift
//  TipCalculatorTests
//
//  Created by DiOS on 09.08.2023.
//

import XCTest
import SnapshotTesting

@testable import TipCalculator

final class TipCalculatorSnapshotTest: XCTestCase {
    private var screenWidth: CGFloat {
        return UIScreen.main.bounds.size.width
    }
    
    func testLogoView() {
        let size = CGSize(width: screenWidth, height: 48)
        
        let view = LogoView()
    
        assertSnapshot(matching: view, as: .image(size: size))
    }
    
    func testResultView() {
        let size = CGSize(width: screenWidth, height: 224)
        
        let view = ResultView()
    
        assertSnapshot(matching: view, as: .image(size: size))
    }
    
    func testResultViewWithValues() {
        let size = CGSize(width: screenWidth, height: 224)
        let result = ResultModel(
            amountPerPerson: 100.25,
            totalBill: 45,
            totalTip: 60)
        let view = ResultView()
        view.configure(with: result)
    
        assertSnapshot(matching: view, as: .image(size: size))
    }
    
    func testTipInputView() {
        let size = CGSize(width: screenWidth, height: 128)
        
        let view = TipInputView()
    
        assertSnapshot(matching: view, as: .image(size: size))
    }
    
    func testTipInputViewWithSelection() {
        let size = CGSize(width: screenWidth, height: 128)
        
        let view = TipInputView()
        let button = view.allSubViewsOf(type: UIButton.self).first
        button?.sendActions(for: .touchUpInside)
    
        assertSnapshot(matching: view, as: .image(size: size))
    }
    
    func testBillInputView() {
        let size = CGSize(width: screenWidth, height: 56)
        
        let view = BillInputView()
    
        assertSnapshot(matching: view, as: .image(size: size))
    }
    
    func testBillInputViewWithValues() {
        let size = CGSize(width: screenWidth, height: 56)
        
        let view = BillInputView()
        let textView = view.allSubViewsOf(type: UITextField.self).first
        textView?.text = "500"
    
        assertSnapshot(matching: view, as: .image(size: size))
    }
    
    func testSplitInputView() {
        let size = CGSize(width: screenWidth, height: 56)
        
        let view = SplitInputView()
    
        assertSnapshot(matching: view, as: .image(size: size), record: false)
    }
    
    func testSplitInputViewWithSelection() {
        let size = CGSize(width: screenWidth, height: 56)
        
        let view = SplitInputView()
        let button = view.allSubViewsOf(type: UIButton.self).last
        button?.sendActions(for: .touchUpInside)
    
        assertSnapshot(matching: view, as: .image(size: size))
    }
}
