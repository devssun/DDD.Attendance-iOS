//
//  PositionCardView.swift
//  DDD.Attendance
//
//  Created by Hakyung Kim on 15/09/2019.
//  Copyright © 2019 DDD. All rights reserved.
//

import UIKit

import SnapKit
import ReactiveCocoa

@IBDesignable
class PositionCardView: UIControl {
    override var isSelected: Bool {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable
    var text: String = "" {
        didSet {
            textLabel.text = text
        }
    }
    
    @IBInspectable
    var image: UIImage? {
        didSet {
            imageView.image = image
            imageView.sizeToFit()
        }
    }
    
    @IBInspectable
    var positionIndex: Int {
        get {
            return position.rawValue
        }
        set(index) {
            position = Position(rawValue: index) ?? .none
            updateView()
        }
    }
    
    var position: Position = .none
    
    private var textLabel: UILabel = {
        let textLabel = UILabel()
        textLabel.font = .systemFont(ofSize: 15)
        textLabel.textAlignment = .center
        textLabel.textColor = UIColor(red: 51/255, green: 51/255, blue: 51/255, alpha: 1.0)
        return textLabel
    }()
    
    private var checkButton: UIButton = {
        let checkButton = UIButton()
        checkButton.setImage(UIImage(named: "signup_check_off"), for: .normal)
        checkButton.setImage(UIImage(named: "signup_check_on"), for: .selected)
        checkButton.sizeToFit()
        return checkButton
    }()
    
    private var imageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        initView()
    }
    
    private func initView() {
        layer.cornerRadius = 8
        layer.borderColor = UIColor(red: 21/255, green: 21/255, blue: 21/255, alpha: 1.0).cgColor

        addSubview(checkButton)
        checkButton.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(12)
            make.right.equalTo(self).offset(-12)
        }
        
        addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(40)
            make.centerX.equalTo(self)
        }
        
        addSubview(textLabel)
        textLabel.snp.makeConstraints { (make) in
            make.top.equalTo(imageView.snp.bottom).offset(15)
            make.centerX.equalTo(self)
        }

        switch position {
        case .designer:
            textLabel.text = "Designer"
            imageView.image = UIImage(named: "signup_position_design")
        case .and:
            textLabel.text = "Android Dev"
            imageView.image = UIImage(named: "signup_position_and")
        case .ios:
            textLabel.text = "iOS Dev"
            imageView.image = UIImage(named: "signup_position_ios")
        case .backend:
            textLabel.text = "Backend Dev"
            imageView.image = UIImage(named: "signup_position_backend")
        default:
            break
        }
        
        imageView.sizeToFit()
        updateView()
    }
    
    private func updateView() {
        checkButton.isSelected = isSelected
        layer.borderWidth = isSelected ? 2 : 0
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        
        initView()
    }
}
