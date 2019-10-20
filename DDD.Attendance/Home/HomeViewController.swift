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
    @IBOutlet private weak var bottomTriggerViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var bottomTriggerView: AccountView!
    
    private let viewModel = HomeViewModel()
    private let dataSource = HomeDataSource()
    
    let transition = HomeTransitionCoordinator()
    
    let test = AttendanceListModel(attendance: true, timeStamp: "October 12", title: "디디디 커리큘럼 2번째\n아이디어 기획발표")
    
    static func instantiateViewController() -> HomeViewController {
        return Storyboard.home.viewController(HomeViewController.self)
    }
    
    override func bindData() {
        super.bindData()
        
        tableView.then {
            $0.register(UINib(nibName: AttendanceListCell.defaultReusableId, bundle: nil),
                        forCellReuseIdentifier: AttendanceListCell.defaultReusableId)
            $0.register(UINib(nibName: HomeHeaderCell.defaultReusableId, bundle: nil),
                        forCellReuseIdentifier: HomeHeaderCell.defaultReusableId)
            $0.register(UINib(nibName: WelcomeCell.defaultReusableId, bundle: nil),
                        forCellReuseIdentifier: WelcomeCell.defaultReusableId)
            $0.tableHeaderView = UIView(frame: CGRect.zero)
            $0.tableFooterView = UIView(frame: CGRect.zero)
            $0.separatorInset = UIEdgeInsets(top: 0, left: UIScreen.main.bounds.width, bottom: 0, right: 0)
            $0.dataSource = dataSource
        }
    }
    
    override func bindStyle() {
        super.bindStyle()
        
        navigationController.then {
            $0.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
            $0.navigationBar.shadowImage = UIImage()
            $0.navigationBar.backgroundColor = UIColor.clear
        }
    }
    
    override func bindViewModel() {
        super.bindViewModel()
        
        reactive.setupAccountView <~ viewModel.outputs.configureAccountView
        
        reactive.prepareAccountViewController <~ viewModel.outputs.configureAccountView
            .sample(on: reactive.viewWillAppear)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBottomTriggerViewTapGestureRecognizer()
        
        viewModel.inputs.generateQRCode(by: "godpp")
        
        dataSource.load(from: "We suggest you to wear a colorful the gray weather in Milan", with: [test,test,test,test,test,test,test])
        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        bottomTriggerView.show(animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
//        bottomTriggerView.hide(animated: false)
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
    
    func setupBottomTriggerViewTapGestureRecognizer() {
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(bottomTriggerViewTapped))
        recognizer.numberOfTapsRequired = 1
        bottomTriggerView.addGestureRecognizer(recognizer)
    }
    
    @objc func bottomTriggerViewTapped() {
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
