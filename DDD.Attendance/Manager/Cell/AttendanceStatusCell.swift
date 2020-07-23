//
//  AttendanceStatusCell.swift
//  DDD.Attendance
//
//  Created by 최혜선 on 2020/07/18.
//  Copyright © 2020 DDD. All rights reserved.
//

import UIKit

class AttendanceStatusCell: UITableViewCell, BaseCell {
    
    static var defaultReusableId: String = "AttendanceStatusCell"
    
    @IBOutlet private weak var positionImageView: UIImageView!
    @IBOutlet private weak var attendanceDateLabel: UILabel!
    @IBOutlet private weak var statusLabel: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        positionImageView.image = nil
        attendanceDateLabel.text = nil
        statusLabel.text = nil
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureWith(value: AttendanceStatusModel) {
        positionImageView.image = value.position.logoImage
        attendanceDateLabel.text = value.date
        statusLabel.text = value.status == 0 ? "출석" : "지각"
    }
}
