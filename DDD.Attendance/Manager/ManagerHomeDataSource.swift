//
//  ManagerHomeDataSource.swift
//  DDD.Attendance
//
//  Created by 최혜선 on 2020/07/12.
//  Copyright © 2020 DDD. All rights reserved.
//

import UIKit

class ManagerHomeDataSource: BaseDataSource {
    override func configureCell(tableCell cell: UITableViewCell, withValue value: Any) {
        switch (cell, value) {
        case let (cell as HomeMenuCell, value as MenuModel):
            cell.selectionStyle = .none
            cell.configureWith(value: value)
        default:
            fatalError("Invaild \(cell), \(value)")
        }
    }
    
    func load(from data: [MenuModel]) {
        set(values: data, cellClass: HomeMenuCell.self, inSection: 0)
    }
}
