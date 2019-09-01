//
//  HomeViewModel.swift
//  DDD.Attendance
//
//  Created by ParkSungJoon on 01/09/2019.
//  Copyright © 2019 DDD. All rights reserved.
//

import ReactiveSwift

protocol HomeViewModelInputs {
    
    func generateQRCode(by userID: String)
}

protocol HomeViewModelOutputs {
    
    var setupAccountView: Signal<String, Never> { get }
}

protocol HomeViewModelTypes {
    
    var inputs: HomeViewModelInputs { get }
    
    var outputs: HomeViewModelOutputs { get }
}

class HomeViewModel {
    
    private let userDataProperty = MutableProperty<String?>(nil)
}

extension HomeViewModel: HomeViewModelTypes {
    
    var inputs: HomeViewModelInputs { return self }
    
    var outputs: HomeViewModelOutputs { return self }
}

extension HomeViewModel: HomeViewModelInputs {
    
    func generateQRCode(by userID: String) {
        userDataProperty.value = userID
    }
}

extension HomeViewModel: HomeViewModelOutputs {
    
    var setupAccountView: Signal<String, Never> {
        return userDataProperty.signal.skipNil()
    }
}
