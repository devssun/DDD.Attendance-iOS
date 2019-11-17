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
    
    enum HeaderTitle {
        static let welcome = "Welcome Back"
        static let list = "Calendar List"
    }
    
    override func configureCell(tableCell cell: UITableViewCell, withValue value: Any) {
        switch (cell, value) {
        case let (cell as HomeHeaderCell, value as String):
            cell.configureWith(value: value)
        case let (cell as WelcomeCell, value as String):
            cell.configureWith(value: value)
        case let (cell as AttendanceListCell, value as Curriculum):
            cell.configureWith(value: value)
        default:
            fatalError("Invaild \(cell), \(value)")
        }
    }
    
    func load(from welcomeData: String, with curriculumList: [Curriculum]) {
        appendRow(value: HeaderTitle.welcome, cellClass: HomeHeaderCell.self, toSection: Section.welcome.rawValue)
        appendRow(value: welcomeData, cellClass: WelcomeCell.self, toSection: Section.welcome.rawValue)
        appendRow(value: HeaderTitle.list, cellClass: HomeHeaderCell.self, toSection: Section.welcome.rawValue)
        appendSection(values: curriculumList, cellClass: AttendanceListCell.self)
    }
}
