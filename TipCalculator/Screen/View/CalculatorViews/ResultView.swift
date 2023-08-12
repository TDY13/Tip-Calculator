//
//  ResultView.swift
//  TipCalculator
//
//  Created by DiOS on 06.08.2023.
//

import UIKit

class ResultView: UIView {
    
    private let headerLabel: UILabel = {
        LabelFactory.build(text: "Total p/person",
                           font: ThemeFont.demibold(ofSize: 18))
    }()
    
    private let amountPerPersonLabel: UILabel = {
        let obj = UILabel()
        obj.textAlignment = .center
        let text = NSMutableAttributedString(string: "0 $",
                                             attributes: [.font: ThemeFont.bold(ofSize: 40)])
        text.addAttributes([.font: ThemeFont.bold(ofSize: 24)], range: NSMakeRange(text.length - 1, 1))
        obj.attributedText = text
        obj.accessibilityIdentifier = ScreenIdentifier.ResultView.totalAmountRepPersonValueLabel.rawValue
        return obj
    }()
    
    private let dividerView: UIView = {
        let obj = UIView()
        obj.backgroundColor = ThemeColor.separator
        return obj
    }()
    
    private lazy var vStackView: UIStackView = {
        let obj = UIStackView(arrangedSubviews: [
            headerLabel,
            amountPerPersonLabel,
            dividerView,
            buildSpacerView(height: 0),
            hStackView
        ])
        obj.axis = .vertical
        obj.spacing = 8
        return obj
    }()
    
    private let totalBillView: AmountView = {
        let obj = AmountView(title: "Total bill", textAlignment: .left, amountLabelIdentifier: ScreenIdentifier.ResultView.totalBillValueLabel.rawValue)
        return obj
    }()
    
    private let totalTipView: AmountView = {
        let obj = AmountView(title: "Total tip", textAlignment: .right, amountLabelIdentifier: ScreenIdentifier.ResultView.totalTipValueLabel.rawValue)
        return obj
    }()
    
    private lazy var hStackView: UIStackView = {
        let obj = UIStackView(arrangedSubviews: [
            totalBillView,
            totalTipView
        ])
        obj.axis = .horizontal
        obj.distribution = .fillEqually
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
        backgroundColor = .white
        addSubview(vStackView)
        
        addShadow(offset: CGSize(width: 0, height: 3),
                  color: .black,
                  radius: 12,
                  opacity: 0.1)
        
        vStackView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(24)
        }
        
        dividerView.snp.makeConstraints {
            $0.height.equalTo(2)
        }
    }
    
    func configure(with result: ResultModel) {
        let text = NSMutableAttributedString(
            string: result.amountPerPerson.currencyFormatted,
            attributes: [.font: ThemeFont.bold(ofSize: 40)])
        text.addAttributes([
            .font: ThemeFont.bold(ofSize: 24)],
                           range: NSMakeRange(text.length - 1, 1))
        amountPerPersonLabel.attributedText = text
        totalBillView.configure(amount: result.totalBill)
        totalTipView.configure(amount: result.totalTip)
    }
    
    private func buildSpacerView(height: CGFloat) -> UIView {
        let view = UIView()
        view.heightAnchor.constraint(equalToConstant: height).isActive = true
        return view
    }
}
