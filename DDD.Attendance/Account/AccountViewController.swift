//
//  AccountViewController.swift
//  DDD.Attendance
//
//  Created by seongjun.park on 08/09/2019.
//  Copyright © 2019 DDD. All rights reserved.
//

import UIKit

class AccountViewController: BaseViewController {

    @IBOutlet weak var backgroundView: UIVisualEffectView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var accountView: AccountView!
    
    lazy var accountViewHeight: CGFloat = accountView.frame.height
    var accountModel: AccountModel?
    
    static func instantiateViewController() -> AccountViewController {
        return Storyboard.account.viewController(AccountViewController.self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAccountView(by: accountModel)
    }
}

// MARK: - Private
private extension AccountViewController {
    
    func setupAccountView(by accountModel: AccountModel?) {
        guard let accountModel = accountModel else {
            return
        }
        accountView.configure(by: accountModel)
    }
}

extension AccountViewController: Animatable {
    
    var animatableBackgroundView: UIView {
        return backgroundView
    }
    
    var animatableMainView: UIView {
        return containerView
    }
    
    func prepareBeingDismissed() {
        
    }
}
