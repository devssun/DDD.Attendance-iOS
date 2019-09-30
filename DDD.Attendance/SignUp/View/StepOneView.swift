//
//  StepOneView.swift
//  DDD.Attendance
//
//  Created by ParkSungJoon on 12/09/2019.
//  Copyright © 2019 DDD. All rights reserved.
//

import UIKit

import ReactiveCocoa

class StepOneView: BaseView {
    
    @IBOutlet private weak var lastNameTextField: RoundedTextField!
    @IBOutlet private weak var firstNameTextField: RoundedTextField!
    
    private let nextButton: SignUpButton = SignUpButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
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
                
        }
    }
    
    override func bindViewModel() {
        
    }
}
