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
    
    func generateQRCode()
    
    func remoteCurriculumList()
    
    func remoteBanner()
}

protocol HomeViewModelOutputs {
    
    var configureAccountView: Signal<AccountModel, Never> { get }
    
    var fetchCurriculumList: Signal<[Curriculum], Never> { get }
    
    var fetchBanner: Signal<Banner, Never> { get }
}

protocol HomeViewModelTypes {
    
    var inputs: HomeViewModelInputs { get }
    
    var outputs: HomeViewModelOutputs { get }
}

class HomeViewModel {
    
    private let firebase: Firebase
    private let accountModelProperty = MutableProperty<AccountModel?>(nil)
    private let curriculumListProperty = MutableProperty<[Curriculum]?>(nil)
    private let bannerProperty = MutableProperty<Banner?>(nil)
    
    init(firebase: Firebase = Firebase()) {
        self.firebase = firebase
    }
}

extension HomeViewModel: HomeViewModelTypes {
    
    var inputs: HomeViewModelInputs { return self }
    
    var outputs: HomeViewModelOutputs { return self }
}

extension HomeViewModel: HomeViewModelInputs {
    
    func generateQRCode() {
        guard let uid = firebase.manager.currentUser?.uid else { return }
        accountModelProperty.value = AccountModel(userID: uid,
                                                  period: "출석체크 QR코드",
                                                  qrcode: QRCodeController.generate(from: uid) ?? UIImage())
    }
    
    func remoteCurriculumList() {
        firebase.fetchCurriculumList { [weak self] curriculum in
            self?.curriculumListProperty.value = curriculum
        }
    }
    
    func remoteBanner() {
        firebase.fetchBanner { [weak self] banner in
            self?.bannerProperty.value = banner
        }
    }
}

extension HomeViewModel: HomeViewModelOutputs {
    
    var configureAccountView: Signal<AccountModel, Never> {
        return accountModelProperty.signal.skipNil()
        
    }
    
    var fetchCurriculumList: Signal<[Curriculum], Never> {
        return curriculumListProperty.signal.skipNil()
    }
    
    var fetchBanner: Signal<Banner, Never> {
        return bannerProperty.signal.skipNil()
    }
}
