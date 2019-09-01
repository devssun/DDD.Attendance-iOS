//
//  BaseView.swift
//  DDD.Attendance
//
//  Created by ParkSungJoon on 01/09/2019.
//  Copyright © 2019 DDD. All rights reserved.
//

import UIKit

class BaseView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
        bindData()
        bindViewModel()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
        bindData()
        bindViewModel()
    }
    
    func bindViewModel() {}
    
    func bindData() {}
}

private extension BaseView {
    
    func commonInit() {
        guard let xibName = NSStringFromClass(self.classForCoder)
            .components(separatedBy: ".")
            .last
            else { return }
        guard
            let view = Bundle.main.loadNibNamed(xibName, owner: self, options: nil)?
                .first as? UIView
            else { fatalError("CustomView is not UIView type") }
        view.frame = self.bounds
        self.addSubview(view)
    }
}
