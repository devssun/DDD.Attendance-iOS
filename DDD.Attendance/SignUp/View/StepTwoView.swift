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
    private let nextButton: SignUpButton = SignUpButton()
    private let eyeButton = UIButton()
    
    private let viewModel: SignUpViewModel
    
    init(with viewModel: SignUpViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        initView()
    }

    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initView() {
        nextButton.title = "다음"
        emailTextField.inputAccessoryView = nextButton
        passwordTextField.inputAccessoryView = nextButton
        emailTextField.becomeFirstResponder()
        
        eyeButton.setImage(UIImage(named: "signup_eye_on_default"), for: .normal)
        eyeButton.setImage(UIImage(named: "signup_eye_on_default"), for: .selected)
        
        eyeButton.reactive
            .controlEvents(.touchUpInside)
            .observeValues { [weak self] _ in
                guard let self = self else { return }
                
                self.eyeButton.isSelected.toggle()
                self.passwordTextField.isSecureTextEntry = !self.eyeButton.isSelected
            }
        
        passwordTextField.rightView = eyeButton
        passwordTextField.rightViewMode = .always
        
        emailTextField.reactive
            .controlEvents(.editingDidEndOnExit)
            .observeValues { [weak self] _ in
                guard let self = self else { return }
                
                self.passwordTextField.becomeFirstResponder()
        }
        
        passwordTextField.reactive
            .controlEvents(.editingDidEndOnExit)
            .observeValues { [weak self] _ in
                guard let self = self else { return }
                
                self.passwordTextField.resignFirstResponder()
                self.nextButton.sendActions(for: .touchUpInside)
        }
    }
    
    override func bindViewModel() {
        viewModel.email <~ emailTextField.reactive.continuousTextValues
        viewModel.password <~ passwordTextField.reactive.continuousTextValues
        
        nextButton.reactive.isEnabled <~ viewModel.buttonEnabledSignal
        nextButton.reactive.pressed = CocoaAction(viewModel.nextStepAction)
    }
}
