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
import FirebaseStorage

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
//            var attendance = [String: Bool]()
//            (0..<10).forEach {
//                attendance.updateValue(false, forKey: "\($0)")
//            }
            let userData: [String: Any] = [
                "email": user.email,
                "name": user.name,
                "position": user.position,
                "isManager": false,
                "attendance": []
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
        let storage = Storage.storage()
        let pathReference = storage.reference(withPath: "banner/banner.png")
        
        database.child("banner")
            .observeSingleEvent(of: .value) { snapshot in
                guard let value = snapshot.value, let result = value as? [String: String] else {
                    completion(nil)
                    return
                }
                
                pathReference.getData(maxSize: 1 * 1024 * 1024) { data, error in
                    let imageData = error != nil ? nil : data
                    let banner = Banner(title: result["title"] ?? "",
                                        subTitle: result["subTitle"] ?? "",
                                        imageData: imageData)
                    completion(banner)
                }
        }
    }
    
    func getUser<T: Decodable>(name userName: String, completion: @escaping(APIAttendanceResult<T>) -> Void) {
        database
            .child("users")
            .observeSingleEvent(of: .value, with: { snapshot in
                guard
                    let value = snapshot.value,
                    let result = value as? [String: Any] else {
                        return
                }
                
                let targetUser = result.values
                    .compactMap { ($0 as? [String: Any]) }
                    .first(where: { ($0["name"] as? String) == userName })
                
                if let targetUser = targetUser {
                    do {
                        let jsonData = try JSONSerialization.data(withJSONObject: targetUser, options: .prettyPrinted)
                        let decoded = try JSONDecoder().decode(AttendanceStatusModel.self, from: jsonData)
                        completion(.success(decoded))
                    } catch {
                        completion(.failure(.data))
                    }
                } else {
                    print("not found user")
                    completion(.failure(.data))
                }
            })
    }
}
