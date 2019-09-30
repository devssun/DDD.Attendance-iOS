//
//  SignUpButton.swift
//  DDD.Attendance
//
//  Created by Hakyung Kim on 15/09/2019.
//  Copyright © 2019 DDD. All rights reserved.
//

import UIKit

class SignUpButton: UIButton {
    
    var title: String = "" {
        didSet {
            setTitle(title, for: .normal)
        }
    }
    
    override var isEnabled: Bool {
        didSet {
            updateColor()
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
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: 63)
    }
    
    private func initView() {
        translatesAutoresizingMaskIntoConstraints = false
        isEnabled = false
        titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        
        updateColor()
    }
    
    private func updateColor() {
        if isEnabled {
            backgroundColor = UIColor.black
        } else {
            backgroundColor = UIColor.init(red: 171/255, green: 181/255, blue: 197/255, alpha: 1.0)
        }
    }
}
