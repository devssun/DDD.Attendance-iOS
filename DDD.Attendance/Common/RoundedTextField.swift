//
//  RoundedTextField.swift
//  DDD.Attendance
//
//  Created by Hakyung Kim on 15/09/2019.
//  Copyright © 2019 DDD. All rights reserved.
//

import UIKit

class RoundedTextField: UITextField {
    override var rightView: UIView? {
        didSet {
            rightView?.sizeToFit()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        initView()
    }
    
    private func initView() {
        clipsToBounds = true
        layer.cornerRadius = 10
        font = .systemFont(ofSize: 15)
        backgroundColor = .white
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        let rightViewWidth = rightViewRect(forBounds: bounds).width
        return CGRect(x: 16,
                      y: 12,
                      width: bounds.width - 32 - rightViewWidth,
                      height: bounds.height - 24)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return textRect(forBounds: bounds)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return textRect(forBounds: bounds)
    }
    
    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        guard let rightView = rightView else { return .zero }
        
        return CGRect(x: bounds.width - 16 - rightView.frame.width,
                      y: (bounds.height - rightView.frame.height) / 2,
                      width: rightView.frame.width,
                      height: rightView.frame.height)
    }
}
