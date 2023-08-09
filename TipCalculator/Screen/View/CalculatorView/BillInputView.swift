//
//  BillInputView.swift
//  TipCalculator
//
//  Created by DiOS on 06.08.2023.
//

import UIKit
import Combine
import CombineCocoa

class BillInputView: UIView {
    
    private let headerView: HeaderView = {
        let obj = HeaderView()
        obj.configure(topText: "Enter", bottomText: "your bill")
        return obj
    }()
    
    private let textFieldContainerView: UIView = {
        let obj = UIView()
        obj.backgroundColor = .white
        obj.addCornerRadius(radius: 8.0)
        return obj
    }()
    
    private let currentDenominationLabel: UILabel = {
        let obj = LabelFactory.build(text: "$", font: ThemeFont.bold(ofSize: 24))
        obj.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        return obj
    }()
    
    private lazy var textField: UITextField = {
        let obj = UITextField()
        obj.borderStyle = .none
        obj.font = ThemeFont.demibold(ofSize: 28)
        obj.keyboardType = .decimalPad
        obj.setContentHuggingPriority(.defaultLow, for: .horizontal)
        obj.tintColor = ThemeColor.text
        obj.textColor = ThemeColor.text
//        Add toolbar
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: 36))
        toolbar.barStyle = .default
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done",
                                         style: .plain,
                                         target: self,
                                         action: #selector(didTapDoneButton))
        toolbar.items = [UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil), doneButton]
        toolbar.isUserInteractionEnabled = true
        obj.inputAccessoryView = toolbar
        return obj
    }()
    
    private var cancellables = Set<AnyCancellable>()
    var valuePublisher: AnyPublisher<Double, Never> {
        return billSubject.eraseToAnyPublisher()
    }
    private let billSubject: PassthroughSubject<Double, Never> = .init()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        observe()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        [headerView, textFieldContainerView].forEach(addSubview(_:))
        textFieldContainerView.addSubview(currentDenominationLabel)
        textFieldContainerView.addSubview(textField)
        
        headerView.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.centerY.equalTo(textFieldContainerView.snp.centerY)
            $0.width.equalTo(68)
            $0.trailing.equalTo(textFieldContainerView.snp.leading).offset(-24)
        }
        
        textFieldContainerView.snp.makeConstraints {
            $0.verticalEdges.trailing.equalToSuperview()
        }
        
        currentDenominationLabel.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview()
            $0.leading.equalTo(textFieldContainerView.snp.leading).offset(16)
        }
        
        textField.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview()
            $0.leading.equalTo(currentDenominationLabel.snp.trailing).offset(16)
            $0.trailing.equalTo(textFieldContainerView.snp.trailing).offset(-16)
        }
    }

    private func observe() {
        textField.textPublisher.sink { [unowned self] text in
            billSubject.send(text?.doubleValue ?? 0)
        }.store(in: &cancellables)
    }
    
    func reset() {
        textField.text = nil
        billSubject.send(0)
    }
}

//MARK: - Action(s)
extension BillInputView {
    @objc private func didTapDoneButton() {
        textField.endEditing(true)
    }
}
