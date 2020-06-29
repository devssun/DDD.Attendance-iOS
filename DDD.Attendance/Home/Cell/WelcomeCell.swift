//
//  WelcomeCell.swift
//  DDD.Attendance
//
//  Created by ParkSungJoon on 20/09/2019.
//  Copyright © 2019 DDD. All rights reserved.
//

import UIKit

class WelcomeCell: UITableViewCell, BaseCell {
    
    static var defaultReusableId: String = "WelcomeCell"

    @IBOutlet private weak var subjectLabel: UILabel!
    @IBOutlet private weak var welcomeImageView: UIImageView!
    
    func configureWith(value: Banner) {
        subjectLabel.text = value.subTitle
        if let imageData = value.imageData {
            welcomeImageView.image = UIImage(data: imageData)
        } else {
            welcomeImageView.image = #imageLiteral(resourceName: "mainTemporaryBanner")
        }
    }
}
