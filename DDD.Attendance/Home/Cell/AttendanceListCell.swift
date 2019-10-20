//
//  AttendanceListCell.swift
//  DDD.Attendance
//
//  Created by ParkSungJoon on 04/09/2019.
//  Copyright © 2019 DDD. All rights reserved.
//

import UIKit

class AttendanceListCell: UITableViewCell, BaseCell {
    
    static var defaultReusableId: String = "AttendanceListCell"

    @IBOutlet private weak var attendanceImageView: UIImageView!
    @IBOutlet private weak var attendanceTitleLabel: UILabel!
    @IBOutlet private weak var attendanceTimeStampLabel: UILabel!
    
    func configureWith(value: AttendanceListModel) {
        attendanceTitleLabel.text = value.title
        attendanceTimeStampLabel.text = value.timeStamp
    }
}
