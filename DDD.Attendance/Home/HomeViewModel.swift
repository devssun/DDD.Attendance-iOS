//
//  HomeViewModel.swift
//  DDD.Attendance
//
//  Created by ParkSungJoon on 01/09/2019.
//  Copyright © 2019 DDD. All rights reserved.
//

import UIKit
import ReactiveSwift

protocol HomeViewModelInputs {
    
    func generateQRCode(by userID: String)
}

protocol HomeViewModelOutputs {
    
    var configureAccountView: Signal<AccountModel, Never> { get }
}

protocol HomeViewModelTypes {
    
    var inputs: HomeViewModelInputs { get }
    
    var outputs: HomeViewModelOutputs { get }
}

class HomeViewModel {
    
    private let accountModelProperty = MutableProperty<AccountModel?>(nil)
}

extension HomeViewModel: HomeViewModelTypes {
    
    var inputs: HomeViewModelInputs { return self }
    
    var outputs: HomeViewModelOutputs { return self }
}

extension HomeViewModel: HomeViewModelInputs {
    
    func generateQRCode(by userID: String) {
        accountModelProperty.value = AccountModel(userID: userID,
                                                  period: "DDD.3기",
                                                  qrcode: QRCodeController.generate(from: userID) ?? UIImage())
    }
}

extension HomeViewModel: HomeViewModelOutputs {
    
    var configureAccountView: Signal<AccountModel, Never> {
        return accountModelProperty.signal.skipNil()
        
    }
}
