//
//  BaseCell.swift
//  DDD.Attendance
//
//  Created by ParkSungJoon on 01/09/2019.
//  Copyright © 2019 DDD. All rights reserved.
//

import Foundation

protocol BaseCell: class {
    
    /// Generic Type of Data
    associatedtype Value
    
    static var defaultReusableId: String { get }
    
    /// Configure Cell with Generic Data Value
    func configureWith(value: Value)
}
