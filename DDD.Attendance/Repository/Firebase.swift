//
//  Auth.swift
//  DDD.Attendance
//
//  Created by ParkSungJoon on 06/10/2019.
//  Copyright © 2019 DDD. All rights reserved.
//

import CodableFirebase
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
            var attendance = [String: Bool]()
            (0..<10).forEach {
                attendance.updateValue(false, forKey: "\($0)")
            }
            let userData: [String: Any] = [
                "email": user.email,
                "name": user.name,
                "position": user.position,
                "isManager": false,
                "attendance": attendance
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
            .observeSingleEvent(of: .value, with: { snapshot in
                let value = snapshot.value as? NSDictionary
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
    
    func attendance(userId: String, isLate: Bool, timeStamp: Int64, completion: @escaping(Bool) -> Void) {
        let attendance: [String: String] = [
            "result": isLate ? "1" : "0"
        ]
        database
            .child("users")
            .child(userId)
            .child("attendance")
            .child("\(timeStamp)")
            .setValue(attendance, withCompletionBlock: { error, _ in
                completion(error == nil)
            })
    }
    
    func fetchCurriculumList(completion: @escaping ([Curriculum]?) -> Void) {
        database.child("curriculum")
            .observeSingleEvent(of: .value) { snapshot in
                guard
                    let value = snapshot.value,
                    let result = value as? [[String: Any]] else {
                        completion(nil)
                        return
                }
                
                let results = result.enumerated().map { offset, element in
                    return Curriculum(date: element["date"] as? String ?? "",
                                      title: element["title"] as? String ?? "",
                                      isDone: element["isDone"] as? Bool ?? false,
                                      index: offset + 1)
                }
                completion(results)
        }
    }
    
    func fetchBanner(completion: @escaping(Banner?) -> Void) {
        database.child("banner")
            .observeSingleEvent(of: .value) { snapshot in
                guard let value = snapshot.value, let result = value as? [String: String] else {
                    completion(nil)
                    return
                }
                
                guard let url = URL(string: "gs://ddd-project-a6eb3.appspot.com/banner/banner.png") else {
                    return
                }
                
                let data = try? Data(contentsOf: url)
                let banner = Banner(title: result["title"] ?? "",
                                    subTitle: result["subTitle"] ?? "",
                                    image: data)
                completion(banner)
        }
    }
}
