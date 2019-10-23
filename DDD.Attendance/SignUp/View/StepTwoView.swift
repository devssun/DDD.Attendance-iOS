//
//  StepTwoView.swift
//  DDD.Attendance
//
//  Created by ParkSungJoon on 12/09/2019.
//  Copyright © 2019 DDD. All rights reserved.
//

import UIKit

import ReactiveCocoa
import ReactiveSwift

class StepTwoView: BaseView {
    
    @IBOutlet weak var emailTextField: RoundedTextField!
    @IBOutlet weak var passwordTextField: RoundedTextField!
    @IBOutlet weak var errorTextLabel: UILabel!
    
    private let nextButton: SignUpButton = SignUpButton()
    private let eyeButton: UIButton = UIButton()
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
        emailTextField.inputAccessoryView = nextButton
        passwordTextField.inputAccessoryView = nextButton
        passwordTextField.rightView = eyeButton
        passwordTextField.rightViewMode = .always

        emailTextField.delegate = self
        passwordTextField.delegate = self
        
        eyeButton.setImage(UIImage(named: "signup_eye_on_default"), for: .normal)
        eyeButton.setImage(UIImage(named: "signup_eye_on_default"), for: .selected)
        
        eyeButton.reactive
            .controlEvents(.touchUpInside)
            .observeValues { [weak self] _ in
                guard let self = self else { return }
                
                self.eyeButton.isSelected.toggle()
                self.passwordTextField.isSecureTextEntry = !self.eyeButton.isSelected
            }
       
        nextButton.title = "다음"
        nextButton.isEnabled = false
        
        emailTextField.becomeFirstResponder()
    }
    
    override func bindViewModel() {
        viewModel.email <~ emailTextField.reactive.continuousTextValues
        viewModel.password <~ passwordTextField.reactive.continuousTextValues
        
        nextButton.reactive.isEnabled <~ viewModel.stepTwoBtnEnabledSignal
        errorTextLabel.reactive.textColor <~ viewModel.validationResultSignal
        reactive.pressNextButton <~ nextButton.reactive
            .controlEvents(.touchUpInside)
            .skipRepeats()
    }
    
    func pressNextButton() {
        viewModel.pressNextButton()
    }
}

extension StepTwoView: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        delegate?.setContentOffset(point: CGPoint(x: 0, y: textField.frame.origin.y - 150), animated: true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == emailTextField {
            passwordTextField.becomeFirstResponder()
        } else if textField == passwordTextField {
            if nextButton.isEnabled {
                passwordTextField.resignFirstResponder()
                nextButton.sendActions(for: .touchUpInside)
            } else {
                emailTextField.becomeFirstResponder()
            }
        }
    }
}

extension Reactive where Base: StepTwoView {
    var pressNextButton: BindingTarget<SignUpButton> {
        return makeBindingTarget({ base, _ in
            base.pressNextButton()
        })
    }
}
