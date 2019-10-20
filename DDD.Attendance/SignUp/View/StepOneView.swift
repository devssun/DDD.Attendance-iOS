//
//  StepOneView.swift
//  DDD.Attendance
//
//  Created by ParkSungJoon on 12/09/2019.
//  Copyright © 2019 DDD. All rights reserved.
//

import UIKit

import ReactiveCocoa
import ReactiveSwift

class StepOneView: BaseView {
    
    @IBOutlet private weak var lastNameTextField: RoundedTextField!
    @IBOutlet private weak var firstNameTextField: RoundedTextField!
    
    private let nextButton: SignUpButton = SignUpButton()
    private let viewModel: SignUpViewModel
    
    weak var delegate: SignUpViewScrollDelegate?
    
    init(with viewModel: SignUpViewModel, delegate: SignUpViewScrollDelegate) {
        self.viewModel = viewModel
        self.delegate = delegate
        super.init(frame: .zero)
        initView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initView() {
        firstNameTextField.delegate = self
        lastNameTextField.delegate = self
        
        lastNameTextField.inputAccessoryView = nextButton
        firstNameTextField.inputAccessoryView = nextButton
        
        nextButton.title = "다음"
        nextButton.isEnabled = false
        
        lastNameTextField.becomeFirstResponder()
    }
    
    override func bindViewModel() {
        viewModel.lastName <~ lastNameTextField.reactive.continuousTextValues
        viewModel.firstName <~ firstNameTextField.reactive.continuousTextValues
        
        nextButton.reactive.isEnabled <~ viewModel.stepOneBtnEnabledSignal
        reactive.pressNextButton <~ nextButton.reactive
            .controlEvents(.touchUpInside)
            .skipRepeats()
    }
    
    func pressNextButton() {
        viewModel.pressNextButton()
    }
}

extension StepOneView: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        delegate?.setContentOffset(point: CGPoint(x: 0, y: textField.frame.origin.y - 150), animated: true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == lastNameTextField {
            firstNameTextField.becomeFirstResponder()
        } else if textField == firstNameTextField {
            nextButton.sendActions(for: .touchUpInside)
        }
    }
}

extension Reactive where Base: StepOneView {
    var pressNextButton: BindingTarget<SignUpButton> {
        return makeBindingTarget({ base, _ in
            base.pressNextButton()
        })
    }
}


