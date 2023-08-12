//
//  HeaderView.swift
//  TipCalculator
//
//  Created by DiOS on 07.08.2023.
//

import UIKit

class HeaderView: UIView {
    
    private let topLabel: UILabel = {
        LabelFactory.build(text: nil,
                           font: ThemeFont.bold(ofSize: 18))
    }()
    
    private let bottomLabel: UILabel = {
        LabelFactory.build(text: nil,
                           font: ThemeFont.regular(ofSize: 16))
    }()
    
    private let topSpacerView = UIView()
    private let bottomSpacerView = UIView()
    
    private lazy var stackView: UIStackView = {
        let obj = UIStackView(arrangedSubviews: [
        topSpacerView,
        topLabel,
        bottomLabel,
        bottomSpacerView
        ])
        obj.axis = .vertical
        obj.alignment = .leading
        obj.spacing = -4
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
        addSubview(stackView)
        
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        topSpacerView.snp.makeConstraints {
            $0.height.equalTo(bottomSpacerView)
        }
    }
    
    func configure(topText: String, bottomText: String) {
        topLabel.text = topText
        bottomLabel.text = bottomText
    }
}
