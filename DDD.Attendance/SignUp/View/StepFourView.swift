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
    
    init(with viewModel: SignUpViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        initView()
    }

    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initView() {
        
    }
    
    override func bindViewModel() {
        
    }
}
