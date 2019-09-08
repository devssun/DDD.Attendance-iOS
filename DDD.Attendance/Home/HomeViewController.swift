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
    @IBOutlet weak var bottomTriggerView: AccountView!
    @IBOutlet weak var bottomTriggerButton: UIButton!
    @IBOutlet weak var bottomTriggerViewHeightConstraint: NSLayoutConstraint!
    
    private let viewModel = HomeViewModel()
    private let dataSource = HomeDataSource()
    
    let transition = HomeTransitionCoordinator()
    var testModel = [AttendanceListModel]()
    
    static func instantiateViewController() -> HomeViewController {
        return Storyboard.home.viewController(HomeViewController.self)
    }
    
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
        
        reactive.prepareAccountViewController <~ viewModel.outputs.configureAccountView
            .sample(on: reactive.viewWillAppear)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for _ in 0..<30 {
            testModel.append(AttendanceListModel(attendance: true, timeStamp: "\(Date())", title: "test"))
        }
        viewModel.inputs.generateQRCode(by: "godpp")
        dataSource.load(from: testModel)
        tableView.reloadData()
        
        bottomTriggerButton.addTarget(self, action: #selector(bottomTriggerButtonTapped), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        bottomTriggerView.show(animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        bottomTriggerView.hide(animated: false)
    }
    
    // setup
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        bottomTriggerView.roundCorners(top: true, cornerRadii: 25.0)
    }
}

// MARK: - Private
private extension HomeViewController {
    
    func setupAccountView(by accountData: AccountModel) {
       bottomTriggerView.configure(by: accountData)
    }
    
    func prepareAccountViewController(by accountData: AccountModel) {
        transition.prepareViewforCustomTransition(fromViewController: self, with: accountData)
    }
    
    @objc func bottomTriggerButtonTapped() {
        if let viewControllerToPresent = transition.toViewController {
            present(viewControllerToPresent, animated: true)
        }
    }
}

// MARK: - Reactive
extension Reactive where Base: HomeViewController {
    
    var setupAccountView: BindingTarget<AccountModel> {
        return makeBindingTarget({ base, model in
            base.setupAccountView(by: model)
        })
    }
    
    var prepareAccountViewController: BindingTarget<AccountModel> {
        return makeBindingTarget({ base, model in
            base.prepareAccountViewController(by: model)
        })
    }
}

extension HomeViewController: InteractiveTransitionableViewController {
    
    var interactivePresentTransition: InteractiveAnimator? {
        return transition.interactivePresentTransition
    }
    
    var interactiveDismissTransition: InteractiveAnimator? {
        return transition.interactiveDismissTransition
    }
}
