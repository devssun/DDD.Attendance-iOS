//
//  SearchUsersViewModel.swift
//  DDD.Attendance
//
//  Created by 최혜선 on 2020/07/18.
//  Copyright © 2020 DDD. All rights reserved.
//

import Foundation
import ReactiveSwift

protocol SearchUsersViewModelInputs {
    func remoteAttendanceStatus(name userName: String)
}

protocol SearchUsersViewModelOutputs {
    var fetchAttendanceStatus: Signal<[String: Any], Never> { get }
}

protocol SearchUsersViewModelTypes {
    var inputs: SearchUsersViewModelInputs { get }
    
    var outputs: SearchUsersViewModelOutputs { get }
}

class SearchUsersViewModel {
    private let firebase: Firebase
    private let userProperty = MutableProperty<[String: Any]?>(nil)
    
    init(firebase: Firebase = Firebase()) {
        self.firebase = firebase
    }
}

extension SearchUsersViewModel: SearchUsersViewModelTypes {
    var inputs: SearchUsersViewModelInputs { return self }
    
    var outputs: SearchUsersViewModelOutputs { return self}
}

extension SearchUsersViewModel: SearchUsersViewModelInputs {
    func remoteAttendanceStatus(name userName: String) {
        firebase.getUser(name: userName) { [weak self] result in
            self?.userProperty.value = result
        }
    }
}

extension SearchUsersViewModel: SearchUsersViewModelOutputs {
    var fetchAttendanceStatus: Signal<[String: Any], Never> {
        return userProperty.signal.skipNil()
    }
}
