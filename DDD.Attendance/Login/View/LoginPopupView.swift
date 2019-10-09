//
//  LoginPopupView.swift
//  DDD.Attendance
//
//  Created by ParkSungJoon on 15/09/2019.
//  Copyright © 2019 DDD. All rights reserved.
//

import UIKit
import ReactiveSwift

class LoginPopupView: BaseView {

    @IBOutlet private weak var idTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var loginButton: UIButton!
    
    override func bindViewModel() {
        super.bindViewModel()
        
        loginButton.reactive
            .controlEvents(.touchUpInside)
            .observeValues { _ in
                
        }
    }
}

private extension LoginPopupView {
    
    func login() {

        if let email = idTextField.text, let password = passwordTextField.text {
            
        }
//        Firebase.login(with: <#T##String#>, <#T##password: String##String#>, completion: <#T##(AuthDataResult?) -> Void#>)
    }
}

extension Reactive where Base: LoginPopupView {
    
    var loginFirebase: BindingTarget<Void> {
        return makeBindingTarget({ base, _ in
            
        })
    }
}
