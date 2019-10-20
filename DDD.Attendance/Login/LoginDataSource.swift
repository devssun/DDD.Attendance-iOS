//
//  LoginDataSource.swift
//  DDD.Attendance
//
//  Created by ParkSungJoon on 10/10/2019.
//  Copyright © 2019 DDD. All rights reserved.
//

import UIKit

class LoginDataSource: BaseDataSource {
    
    override func configureCell(collectionCell cell: UICollectionViewCell, withValue value: Any) {
        switch (cell, value) {
        case let (cell as PosterCell, value as PosterModel):
            cell.configureWith(value: value)
        default:
            fatalError("Invaild \(cell), \(value)")
        }
    }
    
    func load(from data: [PosterModel]) {
        set(values: data, cellClass: PosterCell.self, inSection: 0)
    }
}
