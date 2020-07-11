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

    private var descriptionLabel: UILabel = {
       let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.textAlignment = .center
        lb.font = UIFont.systemFont(ofSize: 15.0, weight: .medium)
        lb.numberOfLines = 0
        lb.text = "해당 QR코드를\n스탭에게 제시해주세요"
        lb.textColor = .black
        return lb
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        roundCorners(corners: [.topLeft, .topRight], cornerRadii: 25)
        isUserInteractionEnabled = true
        
        qrcodeImageview.then {
            $0.layer.cornerRadius = $0.frame.height / 4
            $0.layer.borderWidth = 1.0
            $0.layer.borderColor = UIColor.black.cgColor
        }
        
        qrcodeImageview.snp.makeConstraints {
            $0.top.equalTo(snp.top).offset(10)
            $0.width.equalTo(qrcodeImageview.snp.height)
            $0.trailing.equalTo(snp.trailing).offset(-48)
            $0.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).offset(-15)
        }
        
        titleLabel.snp.makeConstraints {
            $0.centerY.equalTo(qrcodeImageview.snp.centerY)
            $0.leading.equalTo(snp.leading).offset(48)
        }
        
        addSubview(descriptionLabel)
        descriptionLabel.isHidden = true
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
            $0.bottom.equalTo(descriptionLabel.snp.top).offset(-24)
        }
        
        titleLabel.snp.remakeConstraints {
            $0.top.equalTo(snp.top).offset(15)
            $0.trailing.equalTo(snp.trailing).offset(-48)
        }
        
        descriptionLabel.isHidden = false
        descriptionLabel.snp.remakeConstraints {
            $0.centerX.equalToSuperview()
        }
    }
    
    func hideDetailAction() {
        titleLabel.text = "출석체크 QR코드"
        
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
        
        descriptionLabel.isHidden = true
    }
}
