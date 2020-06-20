//
//  SetAttendanceViewController.swift
//  DDD.Attendance
//
//  Created by 최혜선 on 2020/06/20.
//  Copyright © 2020 DDD. All rights reserved.
//

import UIKit
import ReactiveCocoa
import ReactiveSwift

class SetAttendanceViewController: BaseViewController {
    
    @IBOutlet fileprivate var showDatePickerButton: UIButton!
    @IBOutlet fileprivate var datePicker: UIDatePicker!
    @IBOutlet fileprivate var openQRScannerButton: UIButton!
    @IBOutlet fileprivate var setDateButton: UIButton!
    private var attendanceTimeStamp: Int64?
    
    static func instantiateViewController() -> SetAttendanceViewController {
        return Storyboard.manager.viewController(SetAttendanceViewController.self)
    }
    
    private var selectedDate = Date() {
        didSet {
            showDatePickerButton.setTitle(selectedDate.dateAndTimetoString(), for: .normal)
        }
    }
    
    private var isSetTime: Bool = false {
        didSet {
            datePicker.isHidden = !isSetTime
            setDateButton.isHidden = !isSetTime
        }
    }

    override func bindData() {
        super.bindData()
        // Do any additional setup after loading the view.
    }
    
    override func bindViewModel() {
        super.bindViewModel()
        showDatePickerButton
            .reactive
            .controlEvents(.touchUpInside)
            .observeValues { [weak self] _ in
                guard let `self` = self else { return }
                self.isSetTime = !self.isSetTime
        }
        
        datePicker
            .reactive
            .controlEvents(.valueChanged)
            .observeValues { [weak self] picker in
                self?.selectedDate = picker.date
        }
        
        openQRScannerButton
            .reactive
            .controlEvents(.touchUpInside)
            .observeValues { [weak self] _ in
                self?.touchedOpenQRScannerButton()
        }
        
        setDateButton
            .reactive
            .controlEvents(.touchUpInside)
            .observeValues { [weak self] _ in
                guard let `self` = self else { return }
                self.isSetTime = false
                self.attendanceTimeStamp = self.selectedDate.getTimeStamp()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        isSetTime = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        selectedDate = Date()
    }
    
    @objc private func touchedOpenQRScannerButton() {
        guard let attendanceTimeStamp = attendanceTimeStamp else {
            showAlert(title: "출석 시간 미 선택", message: "출석 시간을 선택해주세요")
            return
        }
        self.moveScannerViewController(attendanceTimeStamp: attendanceTimeStamp)
    }
    
    @objc func moveScannerViewController(attendanceTimeStamp: Int64) {
        let scannerVC = ScannerViewController()
        scannerVC.attendanceTimeStamp = attendanceTimeStamp
        self.navigationController?.pushViewController(scannerVC, animated: true)
        self.attendanceTimeStamp = nil
    }
}
