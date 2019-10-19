//
//  LoginPopupViewModel.swift
//  DDD.Attendance
//
//  Created by ParkSungJoon on 16/10/2019.
//  Copyright © 2019 DDD. All rights reserved.
//

import ReactiveSwift

protocol LoginPopupViewModelInputs {
    
    func pressLoginButton()
    
    func requestFirebaseAuth(with account: LoginPopupViewModel.Account)
    
    func checkValidAccount(with account: LoginPopupViewModel.Account)
}

protocol LoginPopupViewModelOutputs {
    
    var loginAccount: Signal<LoginPopupViewModel.Account, Never> { get }
    
    var loginResult: Signal<(Bool, String?), Never> { get }
    
    var isValidAccount: Signal<Bool, Never> { get }
}

protocol LoginPopupViewModelTypes {
    
    var inputs: LoginPopupViewModelInputs { get }
    
    var outputs: LoginPopupViewModelOutputs { get }
}

class LoginPopupViewModel {
    
    typealias Account = (String, String)
    
    private let firebase: Firebase
    private let isValidAccountProperty = MutableProperty<Bool?>(nil)
    private let pressLoginButtonProperty = MutableProperty<Void?>(nil)
    private let emailProperty = MutableProperty<String>("")
    private let passwordProperty = MutableProperty<String>("")
    private let loginResultProperty = MutableProperty<(Bool, String?)>((false, nil))
    
    init(firebase: Firebase = Firebase()) {
        self.firebase = firebase
    }
}

extension LoginPopupViewModel: LoginPopupViewModelTypes {
    
    var inputs: LoginPopupViewModelInputs { return self }
    
    var outputs: LoginPopupViewModelOutputs { return self }
}

extension LoginPopupViewModel: LoginPopupViewModelInputs {
    
    func pressLoginButton() {
        pressLoginButtonProperty.value = ()
        isValidAccountProperty.value = false
    }
    
    func requestFirebaseAuth(with account: LoginPopupViewModel.Account) {
        loginFirebase(with: account.0, account.1)
    }
    
    func checkValidAccount(with account: LoginPopupViewModel.Account) {
        emailProperty.value = account.0
        passwordProperty.value = account.1
    }
}

extension LoginPopupViewModel: LoginPopupViewModelOutputs {
    
    var loginAccount: Signal<Account, Never> {
        return isValidAccountProperty.signal.skipNil()
            .sample(on: pressLoginButtonProperty.signal.skipNil())
            .filter { $0 }
            .map { [unowned self] _ -> Account in
                return (self.emailProperty.value, self.passwordProperty.value)
            }
    }
    
    var loginResult: Signal<(Bool, String?), Never> {
        return loginResultProperty.signal
    }
    
    var isValidAccount: Signal<Bool, Never> {
        return emailProperty.signal
            .combineLatest(with: passwordProperty.signal)
            .filterMap { [unowned self] (email, password) in
                let isValid = self.validateEmail(from: email) && self.validatePassword(from: password)
                self.isValidAccountProperty.value = isValid
                return isValid
        }
    }
}

private extension LoginPopupViewModel {
    
    func loginFirebase(with email: String, _ password: String) {
        firebase.login(with: email, password) { [weak self] result in
            if result?.user != nil {
                self?.loginResultProperty.value = (true, nil)
            } else {
                self?.loginResultProperty.value = (false, "Email 또는 Password를 확인해주세요.")
            }
        }
    }
    
    func validateEmail(from text: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let predicate = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return predicate.evaluate(with: text)
    }
    
    func validatePassword(from text: String) -> Bool {
        let passwordRegEx = "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{8,20}$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", passwordRegEx)
        return predicate.evaluate(with: text)
    }
}
