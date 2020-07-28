//
//  NameHeaderCell.swift
//  DDD.Attendance
//
//  Created by 최혜선 on 2020/07/19.
//  Copyright © 2020 DDD. All rights reserved.
//

import UIKit

class NameHeaderCell: UITableViewCell, BaseCell {

    static var defaultReusableId: String = "NameHeaderCell"
    
    @IBOutlet private weak var positionImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    
    func configureWith(value: AttendanceStatusModel) {
        titleLabel.text = "\(value.name) (\(value.attendance?.count ?? 0)/8)"
        positionImageView.image = value.position.logoImage
    }
}
