//
//  Remote.swift
//  DDD.Attendance
//
//  Created by ParkSungJoon on 01/09/2019.
//  Copyright © 2019 DDD. All rights reserved.
//

import Alamofire

class Remote<E: Endpoint> {
    
    typealias ResultCompletion = Result<Data, Error>
    
    let session: Session
    
    init(session: Session = Session.default) {
        self.session = session
    }
    
    func request(from endpoint: E, completion: @escaping (ResultCompletion) -> Void) {
        guard let urlRequest = Request<E>.build(from: endpoint) else {
            debugPrint("Invalid URLRequest")
            return
        }
        
        AF.request(urlRequest).responseData { responseData in
            completion(responseData.result)
        }
    }
}
