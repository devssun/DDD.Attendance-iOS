//
//  StepFourView.swift
//  DDD.Attendance
//
//  Created by ParkSungJoon on 12/09/2019.
//  Copyright © 2019 DDD. All rights reserved.
//

import UIKit
import ReactiveCocoa
import ReactiveSwift
import SnapKit

class StepFourView: BaseView {
    
    @IBOutlet weak var imageView: UIImageView!
    private let viewModel: SignUpViewModel
    private let nextButton: SignUpButton = SignUpButton()
   
    init(with viewModel: SignUpViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        initView()
    }

    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initView() {
        addSubview(nextButton)
        nextButton.snp.makeConstraints { (make) in
            make.top.greaterThanOrEqualTo(imageView.snp.bottom).offset(30)
            make.bottom.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
        }
        nextButton.title = "로그인 하기"
        nextButton.isEnabled = true
    }
    
    override func bindViewModel() {
        reactive.pressNextButton <~ nextButton.reactive
            .controlEvents(.touchUpInside)
            .skipRepeats()
    }
    
    func pressNextButton() {
        viewModel.pressNextButton()
    }
}

extension Reactive where Base: StepFourView {
    var pressNextButton: BindingTarget<SignUpButton> {
        return makeBindingTarget({ base, _ in
            base.pressNextButton()
        })
    }
}

