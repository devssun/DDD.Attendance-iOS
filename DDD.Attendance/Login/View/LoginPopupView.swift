//
//  LoginPopupView.swift
//  DDD.Attendance
//
//  Created by ParkSungJoon on 15/09/2019.
//  Copyright © 2019 DDD. All rights reserved.
//

import UIKit
import ReactiveSwift
import FirebaseAuth

class LoginPopupView: BaseView {

    @IBOutlet private weak var idTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var loginButton: UIButton!
    
    private let viewModel = LoginPopupViewModel()
    
    override func bindViewModel() {
        super.bindViewModel()
        
        reactive.pressLoginButton <~ loginButton.reactive
            .controlEvents(.touchUpInside)
        
        viewModel.outputs.login.observeValues { _ in
            
        }
    }
}

private extension LoginPopupView {
    
    func pressLoginButton(with email: String?, _ password: String?) {
        viewModel.inputs.pressLoginButton(with: email, password)
    }
    
    func getAccount() -> (String?, String?) {
        guard
            let email = idTextField.text,
            let password = passwordTextField.text else {
                return (nil, nil)
        }
        return (email, password)
    }
}

extension Reactive where Base: LoginPopupView {
    
    var pressLoginButton: BindingTarget<UIButton> {
        return makeBindingTarget({ base, _ in
            let account = base.getAccount()
            base.pressLoginButton(with: account.0, account.1)
        })
    }
}
