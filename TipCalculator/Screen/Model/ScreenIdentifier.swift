//
//  ScreenIdentifier.swift
//  TipCalculator
//
//  Created by DiOS on 09.08.2023.
//

import Foundation

enum ScreenIdentifier {
    
    enum LogoView: String {
        case logoView
    }
    
    enum ResultView: String {
        case totalAmountRepPersonValueLabel
        case totalBillValueLabel
        case totalTipValueLabel
    }
    
    enum BillInputView: String {
        case textField
    }
    
    enum TipInputView: String {
        case tenPercentButton
        case fifteenPercentButton
        case twentyPercentButton
        case customTipButton
        case customTipAlertTextField
    }
    
    enum SplitInputView: String {
        case decrementButton
        case incrementButton
        case quantityValueLabel
    }
}
