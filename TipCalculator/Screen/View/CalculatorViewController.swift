//
//  ViewController.swift
//  TipCalculator
//
//  Created by DiOS on 06.08.2023.
//

import UIKit
import Combine
import CombineCocoa

class CalculatorViewController: UIViewController {
    
    private let mainView = CalculatorView()
    private let viewModel = CalculatorViewModel()
    
    private var cancellables = Set<AnyCancellable>()
    
    private lazy var viewTapPublisher: AnyPublisher<Void, Never> = {
        let tapGesture = UITapGestureRecognizer(target: self, action: nil)
        mainView.addGestureRecognizer(tapGesture)
        return tapGesture.tapPublisher.flatMap { _ in
            Just(())
        }.eraseToAnyPublisher()
    }()
    
    private lazy var logoViewTapPublisher: AnyPublisher<Void, Never> = {
        let tapGesture = UITapGestureRecognizer(target: self, action: nil)
        tapGesture.numberOfTapsRequired = 2
        mainView.logoView.addGestureRecognizer(tapGesture)
        return tapGesture.tapPublisher.flatMap { _ in
            Just(())
        }.eraseToAnyPublisher()
    }()
    
    override func loadView() {
        super.loadView()
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initViewController()
    }
    
    private func initViewController() {
        bind()
    }
    
    private func bind() {
        
        let input = CalculatorViewModel.Input(
            billPublisher: mainView.billInputView.valuePublisher,
            tipPublisher: mainView.tipInputView.valuePublisher,
            splitPublisher: mainView.splitInputView.valuePublisher,
            logoViewTapPublisher: logoViewTapPublisher)
        
        let output = viewModel.transform(input: input)
        
        output.updateViewPublisher.sink { [unowned self] result in
            self.mainView.resultView.configure(with: result)
        }.store(in: &cancellables)
        
        output.resetCalculatorPublisher.sink { [unowned self] _ in
            mainView.billInputView.reset()
            mainView.tipInputView.reset()
            mainView.splitInputView.reset()
            
            UIView.animate(
                withDuration: 0.1,
                delay: 0,
                usingSpringWithDamping: 5.0,
                initialSpringVelocity: 0.5,
                options: .curveEaseInOut) {
                    self.mainView.logoView.transform = .init(scaleX: 1.5, y: 1.5)
                } completion: { _ in
                    UIView.animate(withDuration: 0.1) {
                        self.mainView.logoView.transform = .identity
                    }
                }
            
        }.store(in: &cancellables)
    }
    
    private func observe() {
        viewTapPublisher.sink { [unowned self] value in
            view.endEditing(true)
        }.store(in: &cancellables)
    }
}

