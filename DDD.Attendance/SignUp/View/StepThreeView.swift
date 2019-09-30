//
//  StepThreeView.swift
//  DDD.Attendance
//
//  Created by ParkSungJoon on 12/09/2019.
//  Copyright © 2019 DDD. All rights reserved.
//

import UIKit

class StepThreeView: BaseView {

    @IBOutlet weak var designerPositionCardView: PositionCardView!
    @IBOutlet weak var andPositionCardView: PositionCardView!
    @IBOutlet weak var iosPositionCardView: PositionCardView!
    @IBOutlet weak var backendPositionCardView: PositionCardView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
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
