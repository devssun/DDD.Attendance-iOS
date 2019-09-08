//
//  AccountView.swift
//  DDD.Attendance
//
//  Created by ParkSungJoon on 01/09/2019.
//  Copyright © 2019 DDD. All rights reserved.
//

import UIKit

class AccountView: BaseView {

    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var userLabel: UILabel!
    @IBOutlet private weak var qrcodeImageview: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.cornerRadius = 25
        layer.masksToBounds = true
        
        isUserInteractionEnabled = true
    }
    
    func configure(by account: AccountModel) {
        titleLabel.text = account.period
        userLabel.text = account.userID
        qrcodeImageview.image = account.qrcode
    }
}
