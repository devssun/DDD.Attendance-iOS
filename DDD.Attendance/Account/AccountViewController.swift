//
//  AccountViewController.swift
//  DDD.Attendance
//
//  Created by seongjun.park on 08/09/2019.
//  Copyright © 2019 DDD. All rights reserved.
//

import UIKit
import SnapKit
import ReactiveSwift

class AccountViewController: BaseViewController {

    @IBOutlet weak var backgroundView: UIVisualEffectView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var accountView: AccountView!
    @IBOutlet weak var noticeLabel: UILabel!
    
    lazy var accountViewHeight: CGFloat = accountView.frame.height
    var accountModel: AccountModel?
    
    static func instantiateViewController() -> AccountViewController {
        return Storyboard.account.viewController(AccountViewController.self)
    }
    
    override func bindData() {
        super.bindData()
        
        noticeLabel.then {
            $0.text = "This QR code is very safe\nShare to any others"
        }
    }
    
    override func bindViewModel() {
        super.bindViewModel()
        
        reactive.showDetailAction <~ reactive.viewWillAppear
        
        reactive.hideDetailAction <~ reactive.viewWillDisappear
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
    
    func showDetailAction() {
        UIView.animate(withDuration: 0.4) {
            self.accountView.showDetailAction()
            self.view.layoutIfNeeded()
        }
    }
    
    func hideDetailAction() {
        UIView.animate(withDuration: 0.3) {
            self.accountView.hideDetailAction()
            self.view.layoutIfNeeded()
        }
    }
}

extension AccountViewController: Animatable {
    
    var animatableBackgroundView: UIView {
        return backgroundView
    }
    
    var animatableMainView: UIView {
        return containerView
    }
    
    func prepareBeingDismissed() {}
}

extension Reactive where Base: AccountViewController {
    
    var showDetailAction: BindingTarget<Void> {
        return makeBindingTarget({ base, _ in
            base.showDetailAction()
        })
    }
    
    var hideDetailAction: BindingTarget<Void> {
        return makeBindingTarget({ base, _ in
            base.hideDetailAction()
        })
    }
}
