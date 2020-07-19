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
    
    @IBOutlet private weak var titleLabel: UILabel!
    
    func configureWith(value: String) {
        titleLabel.text = value
    }
}
