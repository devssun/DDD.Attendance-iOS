//
//  SearchUsersViewController.swift
//  DDD.Attendance
//
//  Created by 최혜선 on 2020/07/18.
//  Copyright © 2020 DDD. All rights reserved.
//

import UIKit
import ReactiveSwift

class SearchUsersViewController: BaseViewController {
    
    private var searchBar = UISearchBar()
    @IBOutlet private weak var tableView: UITableView!
    
    private let dataSource = SearchUsersDataSource()

    static func instantiateViewController() -> SearchUsersViewController {
        return Storyboard.manager.viewController(SearchUsersViewController.self)
    }
    
    override func bindData() {
        super.bindData()
        
        tableView.then {
            $0.register(UINib(nibName: AttendanceStatusCell.defaultReusableId, bundle: nil),
                        forCellReuseIdentifier: AttendanceStatusCell.defaultReusableId)
            $0.tableFooterView = UIView(frame: .zero)
            $0.dataSource = dataSource
        }
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
        tableView.reloadData()
    }
}
