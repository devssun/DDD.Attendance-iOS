//
//  Endpoint.swift
//  DDD.Attendance
//
//  Created by ParkSungJoon on 01/09/2019.
//  Copyright © 2019 DDD. All rights reserved.
//

import Foundation

typealias Parameters = [String: Any]

protocol Endpoint {
    
    var baseURL: String { get }
    
    var path: String { get }
    
    var method: HTTPMethod { get }
    
    var parameters: Parameters? { get }
}
