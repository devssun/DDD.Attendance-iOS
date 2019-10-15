//
//  LoginPopupViewModel.swift
//  DDD.Attendance
//
//  Created by ParkSungJoon on 16/10/2019.
//  Copyright © 2019 DDD. All rights reserved.
//

import ReactiveSwift

protocol LoginPopupViewModelInputs {
    
    func pressLoginButton(with email: String?, _ password: String?)
}

protocol LoginPopupViewModelOutputs {
    
    var login: Signal<Void, Never> { get }
}

protocol LoginPopupViewModelTypes {
    
    var inputs: LoginPopupViewModelInputs { get }
    
    var outputs: LoginPopupViewModelOutputs { get }
}

class LoginPopupViewModel {
    
    typealias Account = (String, String)
    
    private let firebase: Firebase
    private let emailProperty = MutableProperty<String?>(nil)
    private let passwordProperty = MutableProperty<String?>(nil)
    
    
    
    init(firebase: Firebase = Firebase()) {
        self.firebase = firebase
    }
}

extension LoginPopupViewModel: LoginPopupViewModelTypes {
    
    var inputs: LoginPopupViewModelInputs { return self }
    
    var outputs: LoginPopupViewModelOutputs { return self }
}

extension LoginPopupViewModel: LoginPopupViewModelInputs {
    
    func pressLoginButton(with email: String?, _ password: String?) {
        emailProperty.value = email
        passwordProperty.value = password
    }
}

extension LoginPopupViewModel: LoginPopupViewModelOutputs {
    
    var login: Signal<Void, Never> {
        return emailProperty.signal.skipNil()
            .zip(with: passwordProperty.signal.skipNil()).logEvents()
            .map({ email, password in
                self.loginFirebase(with: email, password)
            }).logEvents()
    }
}

private extension LoginPopupViewModel {
    
    func loginFirebase(with email: String, _ password: String) {
        firebase.login(with: email, password) { result in
            guard let result = result else {
                return
            }
            print(result.user.email)
        }
    }
}
