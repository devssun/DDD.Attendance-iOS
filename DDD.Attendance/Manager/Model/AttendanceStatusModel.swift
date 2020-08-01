//
//  AttendanceStatusModel.swift
//  DDD.Attendance
//
//  Created by 최혜선 on 2020/07/18.
//  Copyright © 2020 DDD. All rights reserved.
//

import UIKit

enum AttendanceStatus: String, Codable {
    case normal = "0"
    case late = "1"
    
    var title: String {
        switch self {
        case .normal:
            return "출석"
        case .late:
            return "지각"
        }
    }
    
    var textColor: UIColor {
        switch self {
        case .normal:
            return UIColor(red: 54.0/255, green: 159.0/255, blue: 255.0/255, alpha: 1.0)
        case .late:
            return .black
        }
    }
}

enum APIPosition: String, Codable {
    case designer = "Designer"
    case and = "AOS"
    case ios = "iOS"
    case backend = "BackEnd"
    
    var logoImage: UIImage? {
        switch self {
        case .designer:
            return UIImage(named: "imgAttendanceCheckDesigner")
        case .and:
            return UIImage(named: "imgAttendanceCheckAndroid")
        case .ios:
            return UIImage(named: "imgAttendanceCheckIos")
        case .backend:
            return UIImage(named: "imgAttendanceCheckServer")
        }
    }
}

enum APIAttendanceResult<T> {
    case success(AttendanceStatusModel)
    case failure(APIError)
    
    enum APIError {
        case data
    }
}

struct Attendance: Codable {
    let time: String
    let result: AttendanceResult
}

struct AttendanceStatusModel: Codable {
    let position: APIPosition
    let name: String
    let email: String
    let attendance: AttendanceDate?
    let isManager: Bool
}

struct AttendanceDate: Codable {
    var dynamicDictionary: [String: AttendanceResult]
    
    var count: Int {
        return attendance.count
    }
    
    var attendance = [Attendance]()
    
    private struct CustomCodingKeys: CodingKey {
        var stringValue: String
        var intValue: Int?
        init?(stringValue: String) {
            self.stringValue = stringValue
        }
        init?(intValue: Int) {
            return nil
        }
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CustomCodingKeys.self)
        self.dynamicDictionary = [String: AttendanceResult]()
        for key in container.allKeys {
            guard let codingKey = CustomCodingKeys(stringValue: key.stringValue) else { return }
            let value = try container.decode(AttendanceResult.self, forKey: codingKey)
            self.dynamicDictionary[key.stringValue] = value
            self.attendance.append(Attendance(time: Date().timeStampToString(timeStamp: (key.stringValue as NSString).longLongValue).toString(), result: value))
        }
    }
}

struct AttendanceResult: Codable {
    let result: AttendanceStatus
}
