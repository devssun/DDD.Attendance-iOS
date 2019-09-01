//
//  Remote.swift
//  DDD.Attendance
//
//  Created by ParkSungJoon on 01/09/2019.
//  Copyright © 2019 DDD. All rights reserved.
//

import Alamofire

class Remote {
    
    let session: Session
    
    init(session: Session = Session.default) {
        self.session = session
    }
    
    func request(completion: @escaping () -> Void) {
//        AF.request(URLRequestConvertible)
    }
}
