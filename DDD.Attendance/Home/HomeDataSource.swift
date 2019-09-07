//
//  HomeDataSource.swift
//  DDD.Attendance
//
//  Created by ParkSungJoon on 01/09/2019.
//  Copyright © 2019 DDD. All rights reserved.
//

import UIKit

class HomeDataSource: BaseDataSource {
    
    override func configureCell(tableCell cell: UITableViewCell, withValue value: Any) {
        switch (cell, value) {
        case let (cell as AttendanceListCell, value as AttendanceListModel):
            cell.configureWith(value: value)
        default:
            fatalError("Invaild \(cell), \(value)")
        }
    }
    
    func load(from data: [AttendanceListModel]) {
        set(values: data, cellClass: AttendanceListCell.self, inSection: 0)
    }
}
