//
//  UIView+Extension.swift
//  DDD.Attendance
//
//  Created by seongjun.park on 08/09/2019.
//  Copyright © 2019 DDD. All rights reserved.
//

import UIKit

extension UIView {
    
    func roundCorners(corners: UIRectCorner, cornerRadii: CGFloat) {
        let maskPath = UIBezierPath(roundedRect: self.bounds,
                                    byRoundingCorners: corners,
                                    cornerRadii:CGSize(width: cornerRadii, height: cornerRadii))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = self.bounds
        maskLayer.path = maskPath.cgPath
        self.layer.mask = maskLayer
    }
    
    func roundCorners(top: Bool, cornerRadii: CGFloat){
        let corners: UIRectCorner = top ? [.topLeft , .topRight] : [.bottomRight , .bottomLeft]
        roundCorners(corners: corners, cornerRadii: cornerRadii)
    }
    
    func roundAllCorners(cornerRadii: CGFloat) {
        let corners: UIRectCorner = .allCorners
        roundCorners(corners: corners, cornerRadii: cornerRadii)
    }
    
    func show(animated: Bool) {
        let timeInterval: TimeInterval = animated ? 0.33 : 0
        UIView.animate(withDuration: timeInterval) {
            self.alpha = 1
        }
    }
    
    func hide(animated: Bool) {
        let timeInterval: TimeInterval = animated ? 0.33 : 0
        UIView.animate(withDuration: timeInterval) {
            self.alpha = 0
        }
    }
}
