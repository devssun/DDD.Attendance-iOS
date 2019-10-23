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
import NVActivityIndicatorView

class LoginPopupView: BaseView {

    @IBOutlet private weak var idTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var loginButton: UIButton!
    
    private let viewModel = LoginPopupViewModel()
    
    var resultHandler: (((Bool, String?)) -> Void)?
    
    override func bindData() {
        super.bindData()
        
        loginButton.then {
            $0.isEnabled = false
        }
    }
    
    override func bindViewModel() {
        super.bindViewModel()
        
        reactive.pressLoginButton <~ loginButton.reactive
            .controlEvents(.touchUpInside)
        
        reactive.requestFirebaseAuth <~ viewModel.outputs.loginAccount
        
        reactive.loginResultHandler <~ viewModel.outputs.loginResult
        
        reactive.isEnabledLoginButton <~ viewModel.outputs.isValidAccount
        
        reactive.checkValidAccount <~ idTextField.reactive.continuousTextValues
            .combineLatest(with: passwordTextField.reactive.continuousTextValues)
    }
    
    func failureAction() {
        passwordTextField.text?.removeAll()
        idTextField.becomeFirstResponder()
    }
}

private extension LoginPopupView {
    
    func pressLoginButton() {
        endEditing(true)
        viewModel.inputs.pressLoginButton()
        let activityData = ActivityData(type: .pacman)
        NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData)
    }
    
    func requestFirebaseAuth(with account: (String, String)) {
        viewModel.inputs.requestFirebaseAuth(with: account)
    }
    
    func checkValidAccount(with account: (String, String)) {
        viewModel.inputs.checkValidAccount(with: account)
    }
    
    func isEnabledLoginButton(with isValid: Bool) {
        loginButton.isEnabled = isValid
    }
}

extension Reactive where Base: LoginPopupView {
    
    var pressLoginButton: BindingTarget<UIButton> {
        return makeBindingTarget({ base, _ in
            base.pressLoginButton()
        })
    }
    
    var requestFirebaseAuth: BindingTarget<(String, String)> {
        return makeBindingTarget({ base, account in
            base.requestFirebaseAuth(with: account)
        })
    }
    
    var loginResultHandler: BindingTarget<(Bool, String?)> {
        return makeBindingTarget({ base, result in
            base.resultHandler?(result)
        })
    }
    
    var checkValidAccount: BindingTarget<(String, String)> {
        return makeBindingTarget({ base, account in
            base.checkValidAccount(with: account)
        })
    }
    
    var isEnabledLoginButton: BindingTarget<Bool> {
        return makeBindingTarget({ base, isValid in
            base.isEnabledLoginButton(with: isValid)
        })
    }
}
