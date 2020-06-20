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
    
    var selectedDate: String = "" {
        didSet {
            showDatePickerButton.setTitle(selectedDate, for: .normal)
        }
    }

    override func bindData() {
        super.bindData()
        // Do any additional setup after loading the view.
        showDatePickerButton.then {
            $0.addTarget(self,
                         action: #selector(touchedShowDatePickerButton),
                         for: .touchUpInside)
        }
        datePicker.then {
            $0.addTarget(self,
                         action: #selector(changedDatePicker(_:)),
                         for: .valueChanged)
        }
        
        openQRScannerButton.then {
            $0.addTarget(self,
                         action: #selector(touchedOpenQRScannerButton),
                         for: .touchUpInside)
        }
        setDateButton.then {
            $0.addTarget(self,
                         action: #selector(touchedSetDateButton),
                         for: .touchUpInside)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        selectedDate = Date().dateAndTimetoString(format: "yyyy년 MM월 dd일 a hh:mm")
    }
    
    @objc private func touchedShowDatePickerButton(_ sender: UIButton) {
        datePicker.isHidden = !datePicker.isHidden
        setDateButton.isHidden = !setDateButton.isHidden
    }
    
    @objc private func changedDatePicker(_ sender: UIDatePicker) {
        selectedDate = sender.date.dateAndTimetoString(format: "yyyy년 MM월 dd일 a hh:mm")
        attendanceTimeStamp = Int64(sender.date.timeIntervalSince1970 * 1000)
    }
    
    @objc private func touchedOpenQRScannerButton() {
        guard let attendanceTimeStamp = attendanceTimeStamp else {
            showAlert(title: "출석 시간 미 선택", message: "출석 시간을 선택해주세요")
            return
        }
        self.moveScannerViewController(attendanceTimeStamp: attendanceTimeStamp)
    }
    
    @objc private func touchedSetDateButton() {
        datePicker.isHidden = true
        setDateButton.isHidden = true
    }
    
    @objc func moveScannerViewController(attendanceTimeStamp: Int64) {
        let scannerVC = ScannerViewController()
        scannerVC.attendanceTimeStamp = attendanceTimeStamp
        self.navigationController?.pushViewController(scannerVC, animated: true)
        self.attendanceTimeStamp = nil
    }
}
