//
//  StepThreeView.swift
//  DDD.Attendance
//
//  Created by ParkSungJoon on 12/09/2019.
//  Copyright © 2019 DDD. All rights reserved.
//

import UIKit

import ReactiveCocoa
import ReactiveSwift
import SnapKit

class StepThreeView: BaseView {

    @IBOutlet weak var designerPositionCardView: PositionCardView!
    @IBOutlet weak var andPositionCardView: PositionCardView!
    @IBOutlet weak var iosPositionCardView: PositionCardView!
    @IBOutlet weak var backendPositionCardView: PositionCardView!
    
    private let nextButton: SignUpButton = SignUpButton()
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
        addSubview(nextButton)
        nextButton.snp.makeConstraints { (make) in
            make.bottom.equalTo(self)
            make.left.equalTo(self)
            make.right.equalTo(self)
        }
        nextButton.title = "다음"
        nextButton.isEnabled = false
    }
    
    override func bindViewModel() {
        reactive.pressPositionCardView <~ designerPositionCardView.reactive
            .controlEvents(.touchUpInside)
        reactive.pressPositionCardView <~ andPositionCardView.reactive
            .controlEvents(.touchUpInside)
        reactive.pressPositionCardView <~ iosPositionCardView.reactive
            .controlEvents(.touchUpInside)
        reactive.pressPositionCardView <~ backendPositionCardView.reactive
            .controlEvents(.touchUpInside)
        nextButton.reactive.isEnabled <~ viewModel.stepThreeBtnEnabledSignal
        nextButton.reactive.pressed = CocoaAction(viewModel.nextStepAction)
    }
    
    func setAllUnChecked() {
        designerPositionCardView.isSelected = false
        iosPositionCardView.isSelected = false
        andPositionCardView.isSelected = false
        backendPositionCardView.isSelected = false
    }
    
    func setPosition(_ position: Position) {
        viewModel.position.value = position
    }
}

extension Reactive where Base: StepThreeView {
    var pressPositionCardView: BindingTarget<PositionCardView> {
        return makeBindingTarget({ base, view in
            base.setAllUnChecked()
            view.isSelected = true
            base.setPosition(view.position)
        })
    }
}
