//
//  AccountView.swift
//  DDD.Attendance
//
//  Created by ParkSungJoon on 01/09/2019.
//  Copyright © 2019 DDD. All rights reserved.
//

import UIKit
import SnapKit

class AccountView: BaseView {

    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var qrcodeImageview: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        roundCorners(corners: [.topLeft, .topRight], cornerRadii: 25)
        isUserInteractionEnabled = true
        
        qrcodeImageview.then {
            $0.layer.cornerRadius = 20
            $0.layer.borderWidth = 1.0
            $0.layer.borderColor = UIColor.white.cgColor
        }
        
        qrcodeImageview.snp.makeConstraints {
            $0.top.equalTo(snp.top).offset(10)
            $0.width.equalTo(qrcodeImageview.snp.height)
            $0.trailing.equalTo(snp.trailing).offset(-48)
        }
        
        titleLabel.snp.makeConstraints {
            $0.centerY.equalTo(qrcodeImageview.snp.centerY)
            $0.leading.equalTo(snp.leading).offset(48)
        }
    }
    
    func configure(by account: AccountModel) {
        titleLabel.text = account.period
        qrcodeImageview.image = account.qrcode
    }
    
    func showDetailAction() {
        titleLabel.text = Date().toString(format: "yyyy년 M월 d일")
        
        qrcodeImageview.then {
            $0.layer.cornerRadius = 0
            $0.layer.borderWidth = 0
            $0.layer.borderColor = UIColor.clear.cgColor
        }
        
        qrcodeImageview.snp.remakeConstraints {
            $0.centerX.equalToSuperview()
            $0.width.equalTo(qrcodeImageview.snp.height)
            $0.centerY.equalTo(snp.centerY).multipliedBy(0.8)
            $0.left.equalToSuperview().offset(92)
        }
        
        titleLabel.snp.remakeConstraints {
            $0.top.equalTo(snp.top).offset(15)
            $0.trailing.equalTo(snp.trailing).offset(-48)
        }
    }
    
    func hideDetailAction() {
        titleLabel.text = "See the details"
        
        qrcodeImageview.then {
            $0.layer.cornerRadius = 20
            $0.layer.borderWidth = 1.0
            $0.layer.borderColor = UIColor.white.cgColor
        }
        
        qrcodeImageview.snp.remakeConstraints {
            $0.top.equalTo(snp.top).offset(15)
            $0.width.equalTo(qrcodeImageview.snp.height)
            $0.trailing.equalTo(snp.trailing).offset(-48)
        }
        
        titleLabel.snp.remakeConstraints {
            $0.centerY.equalTo(qrcodeImageview.snp.centerY)
            $0.leading.equalTo(snp.leading).offset(48)
        }
    }
}
