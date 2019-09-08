//
//  ReuseableView.swift
//  DDD.Attendance
//
//  Created by seongjun.park on 08/09/2019.
//  Copyright © 2019 DDD. All rights reserved.
//

import UIKit

protocol ReusableView: class {}

extension ReusableView {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

extension UIViewController: ReusableView {}
extension UIView: ReusableView {}
