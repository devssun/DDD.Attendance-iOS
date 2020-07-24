//
//  AttendanceStatusModel.swift
//  DDD.Attendance
//
//  Created by 최혜선 on 2020/07/18.
//  Copyright © 2020 DDD. All rights reserved.
//

import Foundation

enum AttendanceStatus: Int, Codable {
    case normal = 0
    case late = 1
    
    var title: String {
        switch self {
        case .normal:
            return "출석"
        case .late:
            return "지각"
        }
    }
}

struct AttendanceStatusModel: Codable {
    let position: String
    let name: String
    let email: String
    let attendance: [Double: AttendanceResult]
    let isManager: Int
    
    enum CodingKeys: String, CodingKey {
        case position, name, email, isManager, attendance
    }
}

struct AttendanceResult: Codable {
    let result: Int
    
    enum CodingKeys: String, CodingKey {
        case result
    }
}
