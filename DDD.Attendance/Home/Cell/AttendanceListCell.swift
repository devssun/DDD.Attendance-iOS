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
    
    override func prepareForReuse() {
        super.prepareForReuse()
        attendanceImageView.image = nil
        attendanceTitleLabel.text = nil
        attendanceTimeStampLabel.text = nil
    }
    
    func configureWith(value: Curriculum) {
        attendanceTitleLabel.text = "디디디 커리큘럼 \(value.index)번째 \n" + value.title
        attendanceTimeStampLabel.text = value.date
        attendanceImageView.image = value.isAttend ? #imageLiteral(resourceName: "btnCheck") : #imageLiteral(resourceName: "btnCheckGray")
    }
}
