//
//  LoginPopupViewController.swift
//  DDD.Attendance
//
//  Created by ParkSungJoon on 15/09/2019.
//  Copyright © 2019 DDD. All rights reserved.
//

import UIKit
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
    }
}

// MARK: - Private
private extension LoginPopupViewController {
    
    func moveHomeViewController() {
        let homeVC = HomeViewController.instantiateViewController()
        UIApplication.shared.keyWindow?.rootViewController = homeVC
    }
    
    func loginFailureAction(with message: String?) {
        message.then {
            showAlert(title: "로그인 실패", message: $0)
        }
        loginPopupView.failureAction()
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
