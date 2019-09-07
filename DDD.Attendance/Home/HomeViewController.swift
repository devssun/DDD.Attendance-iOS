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
    private let dataSource = HomeDataSource()
    
    var testModel = [AttendanceListModel]()
    
    override func bindData() {
        super.bindData()
        
        tableView.register(UINib(nibName: AttendanceListCell.defaultReusableId, bundle: nil), forCellReuseIdentifier: AttendanceListCell.defaultReusableId)
        tableView.tableHeaderView = UIView(frame: CGRect.zero)
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        tableView.dataSource = dataSource
    }
    
    override func bindViewModel() {
        super.bindViewModel()
        
        reactive.setupAccountView <~ viewModel.outputs.configureAccountView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for _ in 0..<30 {
            testModel.append(AttendanceListModel(attendance: true, timeStamp: "\(Date())", title: "test"))
        }
        viewModel.inputs.generateQRCode(by: "godpp")
        dataSource.load(from: testModel)
        tableView.reloadData()
    }
}

// MARK: - Private
private extension HomeViewController {
    
    func setupAccountView(by accountData: AccountModel) {
       accountView.configure(by: accountData)
    }
}

// MARK: - Reactive
extension Reactive where Base: HomeViewController {
    
    var setupAccountView: BindingTarget<AccountModel> {
        return makeBindingTarget({ base, qrcode in
            base.setupAccountView(by: qrcode)
        })
    }
}
