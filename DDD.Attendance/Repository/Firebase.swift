//
//  Auth.swift
//  DDD.Attendance
//
//  Created by ParkSungJoon on 06/10/2019.
//  Copyright © 2019 DDD. All rights reserved.
//

import FirebaseAuth

class Firebase {
    
    let manager: Auth
    
    init(manager: Auth = Auth.auth()) {
        self.manager = manager
    }
    
    func login(with email: String, _ password: String, completion: @escaping (AuthDataResult?) -> Void) {
        manager.signIn(withEmail: email, password: password) { value, error in
            guard let value = value else {
                completion(nil)
                return
            }
            completion(value)
        }
    }
}
