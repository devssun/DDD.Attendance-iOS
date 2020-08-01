//
//  SearchUsersViewController.swift
//  DDD.Attendance
//
//  Created by 최혜선 on 2020/07/18.
//  Copyright © 2020 DDD. All rights reserved.
//

import UIKit
import ReactiveCocoa
import ReactiveSwift

class SearchUsersViewController: BaseViewController {
    
    private var searchController = UISearchController()
    @IBOutlet private weak var tableView: UITableView!
    
    private let viewModel = SearchUsersViewModel()
    private let dataSource = SearchUsersDataSource()

    static func instantiateViewController() -> SearchUsersViewController {
        return Storyboard.manager.viewController(SearchUsersViewController.self)
    }
    
    override func bindData() {
        super.bindData()
        
        tableView.then {
            $0.register(UINib(nibName: AttendanceStatusCell.defaultReusableId, bundle: nil),
                        forCellReuseIdentifier: AttendanceStatusCell.defaultReusableId)
            $0.register(UINib(nibName: NameHeaderCell.defaultReusableId, bundle: nil),
                        forCellReuseIdentifier: NameHeaderCell.defaultReusableId)
            $0.tableFooterView = UIView(frame: .zero)
            $0.dataSource = dataSource
        }
        
        searchController = UISearchController(searchResultsController: nil)
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "이름 입력"
        searchController.searchBar.delegate = self
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
    }
    
    override func bindViewModel() {
        super.bindViewModel()
    }
    
    override func bindStyle() {
        super.bindStyle()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        reactive.loadAttendanceStatus <~ viewModel.outputs.fetchAttendanceStatus
    }
}

private extension SearchUsersViewController {
    func loadStatus(with statusList: AttendanceStatusModel) {
        guard statusList.attendance != nil else {
            showAlert(title: "DDD", message: "출석 데이터가 없습니다.")
            return
        }
        dataSource.clearValues()
        dataSource.loadStatus(with: statusList)
        tableView.reloadData()
    }
}

extension SearchUsersViewController: UISearchBarDelegate, UISearchTextFieldDelegate {
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        guard let searchName = searchBar.text else { return true }
        viewModel.inputs.remoteAttendanceStatus(name: searchName)
        return true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        dataSource.clearValues()
        tableView.reloadData()
    }
}

extension Reactive where Base: SearchUsersViewController {
    var loadAttendanceStatus: BindingTarget<AttendanceStatusModel> {
        return makeBindingTarget { base, attendance in
            base.loadStatus(with: attendance)
        }
    }
}
