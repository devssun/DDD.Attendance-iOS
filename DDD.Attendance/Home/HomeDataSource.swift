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
        static let list = "4기 커리큘럼 리스트"
    }
    
    override func configureCell(tableCell cell: UITableViewCell, withValue value: Any) {
        switch (cell, value) {
        case let (cell as HomeHeaderCell, value as String):
            cell.configureWith(value: value)
        case let (cell as WelcomeCell, value as Banner):
            cell.configureWith(value: value)
        case let (cell as AttendanceListCell, value as Curriculum):
            cell.configureWith(value: value)
        default:
            fatalError("Invaild \(cell), \(value)")
        }
    }
    
    func loadBanner(with banner: Banner) {
        appendRow(value: banner.title, cellClass: HomeHeaderCell.self, toSection: Section.welcome.rawValue)
        appendRow(value: banner, cellClass: WelcomeCell.self, toSection: Section.welcome.rawValue)
    }
    
    func loadCurriculum(with curriculumList: [Curriculum]) {
        appendRow(value: HeaderTitle.list, cellClass: HomeHeaderCell.self, toSection: Section.attendance.rawValue)
        appendSection(values: curriculumList, cellClass: AttendanceListCell.self)
    }
}
