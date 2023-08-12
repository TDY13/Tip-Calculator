//
//  TipInputView.swift
//  TipCalculator
//
//  Created by DiOS on 06.08.2023.
//

import UIKit
import Combine
import CombineCocoa

class TipInputView: UIView {
    
    private let headerView: HeaderView = {
        let obj = HeaderView()
        obj.configure(topText: "Choose", bottomText: "your tip")
        return obj
    }()
    
    private lazy var tenPercentTipButton: UIButton = {
        let obj = buildTipButton(tip: .tenPercent)
        obj.accessibilityIdentifier = ScreenIdentifier.TipInputView.tenPercentButton.rawValue
        obj.tapPublisher.flatMap({
            Just(Tip.tenPercent)
        }).assign(to: \.value, on: tipSubject)
            .store(in: &cancellables)
        return obj
    }()
    
    private lazy var fifteenPercentTipButton: UIButton = {
        let obj = buildTipButton(tip: .fifteenPercent)
        obj.accessibilityIdentifier = ScreenIdentifier.TipInputView.fifteenPercentButton.rawValue
        obj.tapPublisher.flatMap({
            Just(Tip.fifteenPercent)
        }).assign(to: \.value, on: tipSubject)
            .store(in: &cancellables)
        return obj
    }()
    
    private lazy var twentyPercentTipButton: UIButton = {
        let obj = buildTipButton(tip: .twentyPercent)
        obj.accessibilityIdentifier = ScreenIdentifier.TipInputView.twentyPercentButton.rawValue
        obj.tapPublisher.flatMap({
            Just(Tip.twentyPercent)
        }).assign(to: \.value, on: tipSubject)
            .store(in: &cancellables)
        return obj
    }()
    
    private lazy var customTipButton: UIButton = {
        let obj = UIButton()
        obj.accessibilityIdentifier = ScreenIdentifier.TipInputView.customTipButton.rawValue
        obj.setTitle("Custom tip", for: .normal)
        obj.titleLabel?.font = ThemeFont.bold(ofSize: 20)
        obj.backgroundColor = ThemeColor.primary
        obj.tintColor = .white
        obj.addCornerRadius(radius: 8)
        obj.tapPublisher.sink { _ in
            self.didTapCustomTipButton()
        }.store(in: &cancellables)
        return obj
    }()
    
    private lazy var buttonsHStackView: UIStackView = {
        let obj = UIStackView(arrangedSubviews: [
        tenPercentTipButton,
        fifteenPercentTipButton,
        twentyPercentTipButton
        ])
        obj.distribution = .fillEqually
        obj.spacing = 16
        obj.axis = .horizontal
        return obj
    }()
    
    private lazy var buttonsVStackView: UIStackView = {
        let obj = UIStackView(arrangedSubviews: [
            buttonsHStackView,
            customTipButton
        ])
        obj.axis = .vertical
        obj.spacing = 16
        obj.distribution = .fillEqually
        return obj
    }()
    
    private let tipSubject: CurrentValueSubject<Tip, Never> = .init(.none)
    var valuePublisher: AnyPublisher<Tip, Never> {
        return tipSubject.eraseToAnyPublisher()
    }
    private var cancellables = Set<AnyCancellable>()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        observe()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        [headerView, buttonsVStackView].forEach(addSubview(_:))
        
        buttonsVStackView.snp.makeConstraints {
            $0.verticalEdges.trailing.equalToSuperview()
        }
        
        headerView.snp.makeConstraints {
            $0.trailing.equalTo(buttonsVStackView.snp.leading).offset(-24)
            $0.centerY.equalTo(buttonsHStackView)
            $0.leading.equalToSuperview()
            $0.width.equalTo(68)
        }
    }
    
    private func didTapCustomTipButton() {
        let alert: UIAlertController = {
            let obj = UIAlertController(title: "Enter custom tip", message: nil, preferredStyle: .alert)
            obj.addTextField { textField in
                textField.placeholder = "Make it generous!"
                textField.keyboardType = .numberPad
                textField.autocorrectionType = .no
                textField.accessibilityIdentifier = ScreenIdentifier.TipInputView.customTipAlertTextField.rawValue
            }
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
            let okAction = UIAlertAction(title: "Ok", style: .default) { [weak self] _ in
                guard let text = obj.textFields?.first?.text,
                      let value = Int(text) else { return }
                self?.tipSubject.send(.custom(value: value))
            }
            [okAction, cancelAction].forEach({obj.addAction($0)})
            return obj
        }()
        parentViewController?.present(alert, animated: true)
    }
    
    private func observe() {
        tipSubject.sink { [unowned self] tip in
            self.resetView()
            
            switch tip {
            case .none: break
            case .tenPercent:
                tenPercentTipButton.backgroundColor = ThemeColor.secondary
            case .fifteenPercent:
                fifteenPercentTipButton.backgroundColor = ThemeColor.secondary
            case .twentyPercent:
                twentyPercentTipButton.backgroundColor = ThemeColor.secondary
            case .custom(value: let value):
                customTipButton.backgroundColor = ThemeColor.secondary
                let text = NSMutableAttributedString(string: "$\(value)", attributes: [.font: ThemeFont.bold(ofSize: 20)])
                text.addAttributes([.font: ThemeFont.bold(ofSize: 14)], range: NSMakeRange(0, 1))
                customTipButton.setAttributedTitle(text, for: .normal)
            }
            
        }.store(in: &cancellables)
    }
    
    private func resetView() {
        [tenPercentTipButton, fifteenPercentTipButton, twentyPercentTipButton, customTipButton].forEach {
            $0.backgroundColor = ThemeColor.primary
        }
        
        let text = NSMutableAttributedString(string: "Custom tip", attributes: [.font: ThemeFont.bold(ofSize: 20)])
        customTipButton.setAttributedTitle(text, for: .normal)
    }
    
    func reset() {
        tipSubject.send(.none)
    }
    
    private func buildTipButton(tip: Tip) -> UIButton {
        let button = UIButton(type: .custom)
        button.backgroundColor = ThemeColor.primary
        button.addCornerRadius(radius: 8.0)
        let text = NSMutableAttributedString(string: tip.stringValue,
                                             attributes: [
                                                .font: ThemeFont.bold(ofSize: 20),
                                                .foregroundColor: UIColor.white
                                             ])
        text.addAttributes([.font: ThemeFont.demibold(ofSize: 14)], range: NSMakeRange(2, 1))
        button.setAttributedTitle( text, for: .normal)
        return button
    }
}
