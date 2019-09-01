//
//  URLRequest.swift
//  DDD.Attendance
//
//  Created by ParkSungJoon on 01/09/2019.
//  Copyright © 2019 DDD. All rights reserved.
//

import Foundation

class Request<E: Endpoint> {
    
    static func build(from endpoint: Endpoint) -> URLRequest? {
        guard let url = URL(string: endpoint.baseURL)?.appendingPathComponent(endpoint.path) else {
            debugPrint("Invalid URL")
            return nil
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = endpoint.method.rawValue
        // TODO: - Parameters
        
        return urlRequest
    }
}
