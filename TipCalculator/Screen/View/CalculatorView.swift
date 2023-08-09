//
//  CalculatorView.swift
//  TipCalculator
//
//  Created by DiOS on 06.08.2023.
//

import UIKit
import SnapKit

class CalculatorView: UIView {
    
    let logoView = LogoView()
    let resultView = ResultView()
    let billInputView = BillInputView()
    let tipInputView = TipInputView()
    let splitInputView = SplitInputView()
    
    private lazy var vStackView: UIStackView = {
        let obj = UIStackView(arrangedSubviews: [
            logoView,
            resultView,
            billInputView,
            tipInputView,
            splitInputView,
            UIView()
        ])
        obj.axis = .vertical
        obj.spacing = 25
        return obj
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        backgroundColor = ThemeColor.bg
        
        addSubview(vStackView)
        
        vStackView.snp.makeConstraints {
            $0.margins.equalToSuperview()
        }
        
        logoView.snp.makeConstraints {
            $0.height.equalTo(48)
        }
        
        resultView.snp.makeConstraints {
            $0.height.equalTo(224)
        }
        
        billInputView.snp.makeConstraints {
            $0.height.equalTo(56)
        }
        
        tipInputView.snp.makeConstraints {
            $0.height.equalTo(56 + 16 + 56)
        }
        
        splitInputView.snp.makeConstraints {
            $0.height.equalTo(56)
        }
    }
}
