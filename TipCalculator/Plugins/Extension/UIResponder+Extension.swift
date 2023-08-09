//
//  UIResponder+Extension.swift
//  TipCalculator
//
//  Created by DiOS on 08.08.2023.
//

import UIKit

extension UIResponder {
    
    var parentViewController: UIViewController? {
        return next as? UIViewController ?? next?.parentViewController
    }
}
