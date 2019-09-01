//
//  HomeViewController.swift
//  DDD.Attendance
//
//  Created by ParkSungJoon on 01/09/2019.
//  Copyright © 2019 DDD. All rights reserved.
//

import UIKit
import ReactiveCocoa
import ReactiveSwift

class HomeViewController: BaseViewController {

    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var accountView: AccountView!
    
    private let viewModel = HomeViewModel()
    
    override func bindData() {
        super.bindData()
        
    }
    
    override func bindViewModel() {
        super.bindViewModel()
        
        reactive.generateQRCode <~ viewModel.outputs.setupAccountView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
}

// MARK: - Private
private extension HomeViewController {
    
    func generateQRCode(by userID: String) -> UIImage? {
        return QRCodeController.generate(from: userID)
    }
}

extension Reactive where Base: HomeViewController {
    
    var generateQRCode: BindingTarget<String> {
        return makeBindingTarget({ base, userID in
            base.generateQRCode(by: userID)
        })
    }
}
