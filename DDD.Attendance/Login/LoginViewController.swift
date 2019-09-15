//
//  LoginViewController.swift
//  DDD.Attendance
//
//  Created by ParkSungJoon on 12/09/2019.
//  Copyright © 2019 DDD. All rights reserved.
//

import UIKit
import ReactiveSwift

class LoginViewController: BaseViewController {

    @IBOutlet private weak var loginPopupButton: UIButton!
    @IBOutlet private weak var signUpButton: UIButton!
    
    private let transition = LoginTransitionCoordinator()
    
    static func instantiateViewController() -> LoginViewController {
        return Storyboard.login.viewController(LoginViewController.self)
    }
    
    override func bindViewModel() {
        super.bindViewModel()
        
        reactive.prepareLoginPopupViewController <~ reactive.viewWillAppear
        
        reactive.presentLoginPopupViewController <~ loginPopupButton.reactive
            .controlEvents(.touchUpInside)
    }
}

// MARK: - Private
private extension LoginViewController {
    
    func presentLoginPopupViewController() {
        if let viewControllerToPresent = transition.toViewController {
            present(viewControllerToPresent, animated: true)
        }
    }
    
    func prepareLoginPopupViewController() {
        transition.prepareViewforCustomTransition(fromViewController: self)
    }
}

// MARK: - Reactive
extension Reactive where Base: LoginViewController {
    
    var presentLoginPopupViewController: BindingTarget<UIButton> {
        return makeBindingTarget({ base, _ in
            base.presentLoginPopupViewController()
        })
    }
    
    var prepareLoginPopupViewController: BindingTarget<Void> {
        return makeBindingTarget({ base, _ in
            base.prepareLoginPopupViewController()
        })
    }
}

extension LoginViewController: InteractiveTransitionableViewController {
    
    var interactivePresentTransition: InteractiveAnimator? {
        return transition.interactivePresentTransition
    }
    
    var interactiveDismissTransition: InteractiveAnimator? {
        return transition.interactiveDismissTransition
    }
}
