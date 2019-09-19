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

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var qrcodeImageview: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.cornerRadius = 25
        layer.masksToBounds = true
        isUserInteractionEnabled = true
        
        qrcodeImageview.snp.makeConstraints {
            $0.width.equalTo(30)
            $0.height.equalTo(30)
            $0.trailing.equalTo(-48)
            $0.centerY.equalTo(titleLabel.snp.centerY)
        }
    }
    
    func configure(by account: AccountModel) {
        titleLabel.text = account.period
        qrcodeImageview.image = account.qrcode
    }
}
