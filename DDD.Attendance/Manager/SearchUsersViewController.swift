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
    private let testModels = [AttendanceStatusModel(position: .iOS, name: "최혜선", date: "2020.07.04", status: 0),
                              AttendanceStatusModel(position: .iOS, name: "최혜선", date: "2020.07.04", status: 1),
                              AttendanceStatusModel(position: .iOS, name: "최혜선", date: "2020.07.04", status: 0),
                              AttendanceStatusModel(position: .iOS, name: "최혜선", date: "2020.07.04", status: 1)]

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
        dataSource.load(from: testModels)
        tableView.reloadData()
    }
}

private extension SearchUsersViewController {
    func loadStatus(with statusList: [AttendanceStatusModel]) {
        dataSource.loadStatus(with: statusList)
        tableView.reloadData()
    }
}
