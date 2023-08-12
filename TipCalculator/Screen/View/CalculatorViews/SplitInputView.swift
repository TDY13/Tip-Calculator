//
//  SplitInputView.swift
//  TipCalculator
//
//  Created by DiOS on 06.08.2023.
//

import UIKit
import Combine
import Combine

class SplitInputView: UIView {
    
    private let headerView: HeaderView = {
        let obj = HeaderView()
        obj.configure(topText: "Split", bottomText: "the total")
        return obj
    }()
    
    private lazy var decrementButton: UIButton = {
        let button = buildButton(text: "-", corners: [.layerMinXMaxYCorner, .layerMinXMinYCorner])
        button.accessibilityIdentifier = ScreenIdentifier.SplitInputView.decrementButton.rawValue
        button.tapPublisher.flatMap { [unowned self] _ in
            Just(splitSubject.value == 1 ? 1 : splitSubject.value - 1)
        }.assign(to: \.value, on: splitSubject)
            .store(in: &cancellables)
        return button
    }()
    
    private lazy var incrementButton: UIButton = {
        let button = buildButton(text: "+", corners: [.layerMaxXMaxYCorner, .layerMaxXMinYCorner])
        button.accessibilityIdentifier = ScreenIdentifier.SplitInputView.incrementButton.rawValue
        button.tapPublisher.flatMap { [unowned self] _ in
            Just(splitSubject.value + 1)
        }.assign(to: \.value, on: splitSubject)
            .store(in: &cancellables)
        return button
    }()
    
    private lazy var quantityLabel: UILabel = {
        let obj = LabelFactory.build(text: "1", font: ThemeFont.bold(ofSize: 20), backgroundColor: .white)
        obj.accessibilityIdentifier = ScreenIdentifier.SplitInputView.quantityValueLabel.rawValue
        return obj
    }()
    
    private lazy var stackView: UIStackView = {
        let obj = UIStackView(arrangedSubviews: [
        decrementButton,
        quantityLabel,
        incrementButton
        ])
        obj.axis = .horizontal
        obj.spacing = 0
        return obj
    }()
    
    private let splitSubject: CurrentValueSubject<Int, Never> = .init(1)
    var valuePublisher: AnyPublisher<Int, Never> {
        return splitSubject.removeDuplicates().eraseToAnyPublisher()
    }
    private var cancellables = Set<AnyCancellable>()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
        observe()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout() {
        [headerView, stackView].forEach(addSubview(_:))
        
        stackView.snp.makeConstraints {
            $0.verticalEdges.trailing.equalToSuperview()
        }
        
        [incrementButton,decrementButton].forEach { button in
            button.snp.makeConstraints {
                $0.width.equalTo(button.snp.height)
            }
        }
        
        headerView.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.centerY.equalTo(stackView.snp.centerY)
            $0.trailing.equalTo(stackView.snp.leading).offset(-24)
            $0.width.equalTo(68)
        }
    }
    
    private func observe() {
        splitSubject.sink { [unowned self] quantity in
            quantityLabel.text = quantity.stringValue
        }.store(in: &cancellables)
    }
    
    private func buildButton(text: String, corners: CACornerMask) -> UIButton {
        let button = UIButton()
        button.setTitle(text, for: .normal)
        button.titleLabel?.font = ThemeFont.bold(ofSize: 20)
        button.addRoundedCorners(corners: corners, radius: 8)
        button.backgroundColor = ThemeColor.primary
        return button
    }
    
    func reset() {
        splitSubject.send(1)
    }
}

