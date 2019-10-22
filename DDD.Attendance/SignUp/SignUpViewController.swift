//
//  SignUpViewController.swift
//  DDD.Attendance
//
//  Created by ParkSungJoon on 12/09/2019.
//  Copyright © 2019 DDD. All rights reserved.
//

import UIKit

import SnapKit
import ReactiveSwift
import ReactiveCocoa

protocol SignUpViewScrollDelegate: class {
    func setContentOffset(point: CGPoint, animated: Bool)
}

class SignUpViewController: BaseViewController {
    
    @IBOutlet weak private var scrollView: UIScrollView!
    @IBOutlet weak private var progressView: UIProgressView!
    @IBOutlet weak private var containerView: UIView!
    @IBOutlet weak private var currentStepLabel: UILabel!
    
    private let viewModel = SignUpViewModel()
    
    static func instantiateViewController() -> SignUpViewController {
        return Storyboard.signup.viewController(SignUpViewController.self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureLayout()
        refreshContainerView()
    }
    
    override func bindViewModel() {
        super.bindViewModel()
        
        progressView.reactive.progress <~ viewModel.progressBarSignal
        currentStepLabel.reactive.text <~ viewModel.currentStepSignal
        
        viewModel.step.signal
            .observe(on: UIScheduler())
            .observeValues { [weak self] _ in
            guard let self = self else { return }
            
            self.refreshContainerView()
        }
        
        viewModel.alertSignal
            .observe(on: UIScheduler())
            .observeValues { [weak self] errMsg in
                self?.showAlert(title: "회원 가입 실패", message: errMsg)
        }
    }
}

// MARK: - Layout
private extension SignUpViewController {
    private func configureLayout() {
        progressView.clipsToBounds = true
        progressView.layer.cornerRadius = 3
        
        progressView.layer.sublayers![1].cornerRadius = 3
        progressView.subviews[1].clipsToBounds = true
    }
    
    private func refreshContainerView() {
        setContentOffset(point: .zero, animated: false)
        
        var stepView: BaseView? = nil
        
        switch viewModel.step.value {
        case .StepOne:
            stepView = StepOneView(with: viewModel, delegate: self)
        case .StepTwo:
            stepView = StepTwoView(with: viewModel, delegate: self)
        case .StepThree:
            stepView = StepThreeView(with: viewModel)
        case .StepFour:
            stepView = StepFourView(with: viewModel)
        case .Complete:
            dismiss(animated: true, completion: nil)
        }
        
        if let view = stepView {
            containerView.subviews.forEach({ $0.removeFromSuperview() })
            containerView.addSubview(view)
            view.snp.makeConstraints { (make) in
                make.top.equalTo(containerView)
                make.left.equalTo(containerView)
                make.right.equalTo(containerView)
                make.height.equalTo(containerView)
            }
        }
    }
}

extension SignUpViewController: SignUpViewScrollDelegate {
    func setContentOffset(point: CGPoint, animated: Bool) {
        scrollView.setContentOffset(point, animated: animated)
    }
}
