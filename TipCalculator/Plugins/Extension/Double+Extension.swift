//
//  Double+Extension.swift
//  TipCalculator
//
//  Created by DiOS on 08.08.2023.
//

import Foundation

extension Double {
    
    var currencyFormatted: String {
        var isWholeNumber: Bool {
            isZero ? true: !isNormal ? false: self == rounded()
        }
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.minimumFractionDigits = isWholeNumber ? 0 : 2
        let formattedCurrency = formatter.string(from: NSNumber(value: self)) ?? ""
        return formattedCurrency
    }
}

