//
//  SignUpViewController.swift
//  DDD.Attendance
//
//  Created by ParkSungJoon on 12/09/2019.
//  Copyright © 2019 DDD. All rights reserved.
//

import UIKit

class SignUpViewController: BaseViewController {
    
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var containerView: UIView!
    
    static func instantiateViewController() -> SignUpViewController {
        return Storyboard.account.viewController(SignUpViewController.self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initView()
    }
    
    private func initView() {
        progressView.clipsToBounds = true
        progressView.layer.cornerRadius = 3
        
        progressView.layer.sublayers![1].cornerRadius = 3
        progressView.subviews[1].clipsToBounds = true
    }
}

// MARK: - Private
private extension SignUpViewController {

}
