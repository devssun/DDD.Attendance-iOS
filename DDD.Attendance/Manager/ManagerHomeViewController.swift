//
//  ManagerHomeViewController.swift
//  DDD.Attendance
//
//  Created by 최혜선 on 2020/07/12.
//  Copyright © 2020 DDD. All rights reserved.
//

import UIKit
import ReactiveSwift

class ManagerHomeViewController: BaseViewController {
    
    @IBOutlet fileprivate weak var tableView: UITableView!
    
    private let dataSource = ManagerHomeDataSource()
    private let menuModels = [MenuModel(title: "출석체크 시작하기", subTitle: "출석체크 준비는 2시 전에 해주세요", iconName: "imgQrcodeStart"),
                              MenuModel(title: "출석현황 검색하기", subTitle: "팀원 출석 현황을 검색할 수 있습니다", iconName: "imgSearch"),
                              MenuModel(title: "로그아웃 하기", subTitle: "", iconName: "hiclipartCom1")]

    static func instantiateViewController() -> ManagerHomeViewController {
        return Storyboard.manager.viewController(ManagerHomeViewController.self)
    }
    
    override func bindData() {
        super.bindData()
        
        tableView.then {
            $0.register(UINib(nibName: HomeMenuCell.defaultReusableId, bundle: nil),
                        forCellReuseIdentifier: HomeMenuCell.defaultReusableId)
            $0.tableHeaderView = UIView(frame: .zero)
            $0.tableFooterView = UIView(frame: .zero)
            $0.separatorStyle = .none
            $0.dataSource = dataSource
            $0.delegate = self
        }
    }
    
    override func bindViewModel() {
        super.bindViewModel()
    }
    
    override func bindStyle() {
        super.bindStyle()
        navigationController.then {
            $0.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
            $0.navigationBar.shadowImage = UIImage()
            $0.navigationBar.backgroundColor = UIColor.clear
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        dataSource.load(from: menuModels)
        tableView.reloadData()
    }
}

extension ManagerHomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            moveSetAttendanceViewController()
        case 1:
            moveSearchUsersViewController()
        case 2:
            signOut()
        default:
            break
        }
    }
    
    private func moveSetAttendanceViewController() {
        let setAttendanceVC = SetAttendanceViewController.instantiateViewController()
        self.navigationController?.pushViewController(setAttendanceVC, animated: true)
    }
    
    private func moveSearchUsersViewController() {
        let setAttendanceVC = SearchUsersViewController.instantiateViewController()
        self.navigationController?.pushViewController(setAttendanceVC, animated: true)
    }
    
    private func signOut() {
        Firebase().signOut { [weak self] isSuccess in
            if isSuccess {
                let loginVC = LoginViewController.instantiateViewController()
                UIApplication.shared.keyWindow?.rootViewController = loginVC
            } else {
                self?.showAlert(title: "로그아웃 실패", message: "로그아웃에 실패하였습니다.")
            }
        }
    }
}
