//
//  LoginPopupViewController.swift
//  DDD.Attendance
//
//  Created by ParkSungJoon on 15/09/2019.
//  Copyright © 2019 DDD. All rights reserved.
//

import UIKit
import ReactiveCocoa
import ReactiveSwift
import NVActivityIndicatorView

class LoginPopupViewController: BaseViewController {

    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var loginPopupView: LoginPopupView!
    
    lazy var loginPopupViewHeight: CGFloat = loginPopupView.frame.height
    
    static func instantiateViewController() -> LoginPopupViewController {
        return Storyboard.login.viewController(LoginPopupViewController.self)
    }
    
    override func bindViewModel() {
        super.bindViewModel()
        
        loginPopupView.resultHandler = { [weak self] result in
            NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
            if result.0 {
                self?.moveHomeViewController()
            } else {
                self?.loginFailureAction(with: result.1)
            }
        }
        
        reactive.keyboardWillShow <~ NotificationCenter.default.reactive
            .keyboard(.willShow)
        
        reactive.keyboardWillHide <~ NotificationCenter.default.reactive
            .keyboard(.willHide)
    }
}

// MARK: - Private
private extension LoginPopupViewController {
    
    func moveHomeViewController() {
        let homeVC = HomeViewController.instantiateViewController()
        let navigationVC = UINavigationController(rootViewController: homeVC)
        UIApplication.shared.keyWindow?.rootViewController = navigationVC
    }
    
    func loginFailureAction(with message: String?) {
        message.then {
            showAlert(title: "로그인 실패", message: $0)
        }
        loginPopupView.failureAction()
    }
    
    func keyboardWillShow(with context: KeyboardChangeContext) {
        if view.frame.origin.y != 0 {
            view.frame.origin.y -= context.beginFrame.height
        }
    }
    
    func keyboardWillHide() {
        view.frame.origin.y = 0
    }
}

// MARK: - Animatable
extension LoginPopupViewController: Animatable {
    
    var animatableBackgroundView: UIView {
        return backgroundView
    }
    
    var animatableMainView: UIView {
        return containerView
    }
    
    func prepareBeingDismissed() {}
}

extension Reactive where Base: LoginPopupViewController {
    
    var keyboardWillShow: BindingTarget<KeyboardChangeContext> {
        return makeBindingTarget({ base, context in
            base.keyboardWillShow(with: context)
        })
    }
    
    var keyboardWillHide: BindingTarget<KeyboardChangeContext> {
        return makeBindingTarget({ base, _ in
            base.keyboardWillHide()
        })
    }
}
