//
//  LoginPopupViewController.swift
//  DDD.Attendance
//
//  Created by ParkSungJoon on 15/09/2019.
//  Copyright © 2019 DDD. All rights reserved.
//

import UIKit

class LoginPopupViewController: BaseViewController {

    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var loginPopupView: LoginPopupView!
    
    lazy var loginPopupViewHeight: CGFloat = loginPopupView.frame.height
    
    static func instantiateViewController() -> LoginPopupViewController {
        return Storyboard.login.viewController(LoginPopupViewController.self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

// MARK: - Private
private extension LoginPopupViewController {
    
}

extension LoginPopupViewController: Animatable {
    
    var animatableBackgroundView: UIView {
        return backgroundView
    }
    
    var animatableMainView: UIView {
        return containerView
    }
    
    func prepareBeingDismissed() {
        
    }
}
