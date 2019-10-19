//
//  StepFourView.swift
//  DDD.Attendance
//
//  Created by ParkSungJoon on 12/09/2019.
//  Copyright © 2019 DDD. All rights reserved.
//

import UIKit

class StepFourView: BaseView {
    
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
            make.bottom.equalTo(self)
            make.left.equalTo(self)
            make.right.equalTo(self)
        }
        nextButton.title = "로그인 하기"
        nextButton.isEnabled = true
        
    }
    
    override func bindViewModel() {
        
    }
}
