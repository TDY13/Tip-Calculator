//
//  LogoView.swift
//  TipCalculator
//
//  Created by DiOS on 06.08.2023.
//

import UIKit

class LogoView: UIView {
    
    private let imageView: UIImageView = {
        let obj = UIImageView(image: .init(named: "icCalculatorBW"))
        obj.contentMode = .scaleAspectFit
        return obj
    }()
    
    private let topLabel: UILabel = {
        let obj = UILabel()
        let text = NSMutableAttributedString(string: "Mr TIP", attributes: [.font: ThemeFont.demibold(ofSize: 16)])
        text.addAttributes([.font: ThemeFont.bold(ofSize: 24)], range: NSMakeRange(3, 3))
        obj.attributedText = text
        return obj
    }()
    
    private let bottomLabel: UILabel = {
        LabelFactory.build(text: "Calculator",
                           font: ThemeFont.demibold(ofSize: 20),
                           textAlignment: .left)
    }()
    
    private lazy var vStackView: UIStackView = {
        let obj = UIStackView(arrangedSubviews: [
        topLabel,
        bottomLabel
        ])
        obj.axis = .vertical
        obj.spacing = -4
        return obj
    }()
    
    private lazy var hStackView: UIStackView = {
        let obj = UIStackView(arrangedSubviews: [
        imageView,
        vStackView
        ])
        obj.axis = .horizontal
        obj.spacing = 8
        obj.alignment = .center
        return obj
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout() {
        
        addSubview(hStackView)
        
        hStackView.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview()
            $0.centerX.equalToSuperview()
        }
        
        imageView.snp.makeConstraints {
            $0.height.equalTo(imageView.snp.width)
        }
    }
}
