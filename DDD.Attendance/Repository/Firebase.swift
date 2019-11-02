//
//  Auth.swift
//  DDD.Attendance
//
//  Created by ParkSungJoon on 06/10/2019.
//  Copyright © 2019 DDD. All rights reserved.
//

import FirebaseAuth
import FirebaseDatabase

class Firebase {
    
    let manager: Auth
    
    private let database = Database.database().reference()
    
    enum LoginStatus {
        case admin
        case `default`
        case failure
    }
    
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
    
    func signUp(with user: UserModel, _ password: String, completion: @escaping (AuthDataResult?) -> Void) {
        manager.createUser(withEmail: user.email, password: password) { value, error in
            guard let value = value else {
                completion(nil)
                return
            }
            let userData: [String: Any] = [
                "email": user.email,
                "name": user.name,
                "position": user.position,
                "isManager": false,
            ]
            Database.database().reference().child("users").child(value.user.uid).setValue(userData)
            completion(value)
        }
    }
    
    func signOut(completion: @escaping (Bool) -> Void) {
        do {
            try manager.signOut()
            completion(true)
        } catch {
            print(error)
            completion(false)
        }
    }
    
    func checkAdminAccunt(completion: @escaping (LoginStatus) -> Void) {
        guard let uid = manager.currentUser?.uid else {
            completion(LoginStatus.failure)
            return
        }
        database
            .child("users")
            .child(uid)
            .observeSingleEvent(of: .value, with: { snapShot in
                let value = snapShot.value as? NSDictionary
                if let isManager = value?["isManager"] as? Bool {
                    isManager
                        ? completion(LoginStatus.admin)
                        : completion(LoginStatus.default)
                } else {
                    completion(LoginStatus.failure)
                }
            }) { error in
                print(error.localizedDescription)
                completion(LoginStatus.failure)
        }
    }
}
