//
//  HomeDataSource.swift
//  DDD.Attendance
//
//  Created by ParkSungJoon on 01/09/2019.
//  Copyright © 2019 DDD. All rights reserved.
//

import UIKit

class HomeDataSource: BaseDataSource {
    
    enum Section: Int {
        case welcome
        case attendance
    }
    
    override func configureCell(tableCell cell: UITableViewCell, withValue value: Any) {
        switch (cell, value) {
        case let (cell as HomeHeaderCell, value as String):
            cell.configureWith(value: value)
        case let (cell as WelcomeCell, value as String):
            cell.configureWith(value: value)
        case let (cell as AttendanceListCell, value as AttendanceListModel):
            cell.configureWith(value: value)
        default:
            fatalError("Invaild \(cell), \(value)")
        }
    }
    
    func load(from welcomeData: String, with attendanceList: [AttendanceListModel]) {
        appendRow(value: "Welcome Back", cellClass: HomeHeaderCell.self, toSection: Section.welcome.rawValue)
        appendRow(value: welcomeData, cellClass: WelcomeCell.self, toSection: Section.welcome.rawValue)
        appendSection(values: attendanceList, cellClass: AttendanceListCell.self)
        set(value: "Calendar List", cellClass: HomeHeaderCell.self, inSection: Section.attendance.rawValue, row: 0)
    }
}
