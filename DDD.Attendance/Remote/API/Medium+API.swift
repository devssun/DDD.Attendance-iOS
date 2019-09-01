//
//  Medium+API.swift
//  DDD.Attendance
//
//  Created by ParkSungJoon on 01/09/2019.
//  Copyright © 2019 DDD. All rights reserved.
//

import Foundation

struct Medium: Endpoint {
    
    var baseURL: String
    
    var path: String
    
    var method: HTTPMethod
    
    var parameters: Parameters?
}

extension Medium {
    
    static func fetchDDDStudyPosts() -> Medium {
        return Medium(baseURL: Environment.medium.rawValue,
                      path: "/@dddstudy1/latest?format=json",
                      method: .get,
                      parameters: nil)
    }
}
