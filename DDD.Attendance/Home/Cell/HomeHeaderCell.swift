//
//  HomeHeaderCell.swift
//  DDD.Attendance
//
//  Created by ParkSungJoon on 20/09/2019.
//  Copyright © 2019 DDD. All rights reserved.
//

import UIKit

class HomeHeaderCell: UITableViewCell, BaseCell {
    
    static var defaultReusableId: String = "HomeHeaderCell"

    @IBOutlet private weak var titleLabel: UILabel!
    
    func configureWith(value: String) {
        titleLabel.text = value
    }
}
