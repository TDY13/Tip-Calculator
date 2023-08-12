//
//  AmountView.swift
//  TipCalculator
//
//  Created by DiOS on 07.08.2023.
//

import UIKit

class AmountView: UIView {
    
    private let title: String
    private let textAlignment: NSTextAlignment
    private let amountLabelIdentifier: String
    
    private lazy var titleLabel: UILabel = {
        LabelFactory.build(text: title,
                           font: ThemeFont.regular(ofSize: 18),
                           textColor: ThemeColor.text,
                           textAlignment: textAlignment)
    }()
    
    private lazy var amountLabel: UILabel = {
        let obj = UILabel()
        obj.textAlignment = textAlignment
        obj.textColor = ThemeColor.primary
        let text = NSMutableAttributedString(string: "0 $",
                                             attributes: [.font: ThemeFont.bold(ofSize: 24)])
        text.addAttributes([
            .font: ThemeFont.bold(ofSize: 16)
        ], range: NSMakeRange(text.length - 1, 1))
        obj.attributedText = text
        obj.accessibilityIdentifier = amountLabelIdentifier
        return obj
    }()
    
    private lazy var stackView: UIStackView = {
        let obj = UIStackView(arrangedSubviews: [
            titleLabel,
            amountLabel
        ])
        obj.axis = .vertical
        return obj
    }()
    
    init(title: String, textAlignment: NSTextAlignment, amountLabelIdentifier: String) {
        self.title = title
        self.textAlignment = textAlignment
        self.amountLabelIdentifier = amountLabelIdentifier
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        addSubview(stackView)
        
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func configure(amount: Double) {
        let text = NSMutableAttributedString(string: amount.currencyFormatted,
                                             attributes: [.font: ThemeFont.bold(ofSize: 24)])
        text.addAttributes([
            .font: ThemeFont.bold(ofSize: 16)
        ], range: NSMakeRange(text.length - 1, 1))
        
        amountLabel.attributedText = text
    }
}
