//
//  SearchUsersDataSource.swift
//  DDD.Attendance
//
//  Created by 최혜선 on 2020/07/18.
//  Copyright © 2020 DDD. All rights reserved.
//

import UIKit

class SearchUsersDataSource: BaseDataSource {
    
    override func configureCell(tableCell cell: UITableViewCell, withValue value: Any) {
        switch (cell, value) {
        case let (cell as NameHeaderCell, value as String):
            cell.configureWith(value: value)
        case let (cell as AttendanceStatusCell, value as AttendanceStatusModel):
            cell.selectionStyle = .none
            cell.configureWith(value: value)
        default:
            fatalError("Invaild \(cell), \(value)")
        }
    }
    
    func loadStatus(with statusList: [AttendanceStatusModel]) {
        appendRow(value: "\(statusList[0].name) (\(statusList.count)/8)", cellClass: NameHeaderCell.self, toSection: 0)
        appendSection(values: statusList, cellClass: AttendanceStatusCell.self)
    }
    
    func load(from data: [AttendanceStatusModel]) {
        set(values: ["\(data[0].name) (\(data.count)/8)"], cellClass: NameHeaderCell.self, inSection: 0)
        set(values: data, cellClass: AttendanceStatusCell.self, inSection: 1)
    }
}
