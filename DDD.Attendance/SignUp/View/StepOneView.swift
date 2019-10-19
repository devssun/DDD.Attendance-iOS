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
        lastNameTextField.inputAccessoryView = nextButton
        firstNameTextField.inputAccessoryView = nextButton
        lastNameTextField.becomeFirstResponder()
        nextButton.isEnabled = false
        
        lastNameTextField.reactive
            .controlEvents(.editingDidEndOnExit)
            .observeValues { [weak self] _ in
                guard let self = self else { return }
                
                self.firstNameTextField.becomeFirstResponder()
            }
        
        firstNameTextField.reactive
            .controlEvents(.editingDidEndOnExit)
            .observeValues { [weak self] _ in
                guard let self = self else { return }
                
                self.nextButton.sendActions(for: .touchUpInside)
            }
    }
    
    override func bindViewModel() {
        viewModel.lastName <~ lastNameTextField.reactive.continuousTextValues
        viewModel.firstName <~ firstNameTextField.reactive.continuousTextValues
        
        nextButton.reactive.isEnabled <~ viewModel.stepOneBtnEnabledSignal
        nextButton.reactive.pressed = CocoaAction(viewModel.nextStepAction)
    }
}
