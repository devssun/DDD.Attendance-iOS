//
//  ScannerViewController.swift
//  DDD.Attendance
//
//  Created by ParkSungJoon on 23/10/2019.
//  Copyright © 2019 DDD. All rights reserved.
//

import UIKit
import AVFoundation

class ScannerViewController: BaseViewController {

    private var captureSession: AVCaptureSession!
    private var previewLayer: AVCaptureVideoPreviewLayer!
    private let firebase = Firebase()
    var attendanceTimeStamp: Int64? {
        didSet {
            descriptionLabel.text = "설정한 출석체크 시간은 \n\(Date().timeStampToString(timeStamp: attendanceTimeStamp ?? 0).dateAndTimetoString())입니다."
        }
    }
    
    private var descriptionLabel: UILabel = {
       let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.textAlignment = .center
        lb.font = UIFont.systemFont(ofSize: 15.0, weight: .medium)
        lb.numberOfLines = 0
        lb.textColor = .black
        return lb
    }()
    
    override func bindData() {
        super.bindData()
        
        view.then {
            $0.backgroundColor = UIColor.black
        }

        navigationItem.title = "Attendance Detector"
        
        setupScanner()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.setHidesBackButton(true, animated: false)
        navigationItem.setRightBarButton(UIBarButtonItem(barButtonSystemItem: .cancel,
                                                         target: self,
                                                         action: #selector(outQRScanner)), animated: true)
        
        guard attendanceTimeStamp != nil else {
            self.showAlert(title: "출석 시간 없음",
                           message: "출석 시간이 등록되지 않았습니다.") { [weak self] _ in
                self?.navigationController?.popViewController(animated: true)
            }
            return
        }
        
        self.view.addSubview(descriptionLabel)
        descriptionLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        descriptionLabel.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        captureSession.startRunning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        captureSession.startRunning()
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
}

// MARK: - Private
private extension ScannerViewController {
    
    func setupScanner() {
        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else {
            return
        }
        let videoInput: AVCaptureDeviceInput
        captureSession = AVCaptureSession()
        
        do {
            videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
        } catch {
            return
        }
        
        if captureSession.canAddInput(videoInput) {
            captureSession.addInput(videoInput)
        } else {
            failed()
            return
        }
        
        let metadataOutput = AVCaptureMetadataOutput()
        
        if captureSession.canAddOutput(metadataOutput) {
            captureSession.addOutput(metadataOutput)
            
            metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            metadataOutput.metadataObjectTypes = [.qr]
        } else {
            failed()
            return
        }
        
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.then {
            $0.frame = view.layer.bounds
            $0.videoGravity = .resizeAspectFill
        }
        
        view.layer.addSublayer(previewLayer)
    }
    
    func failed() {
        let ac = UIAlertController(title: "Scanning not supported",
                                   message: "Your device does not support scanning a code from an item. Please use a device with a camera.",
                                   preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
        captureSession = nil
    }
    
    func processedAttendance(from userId: String) {
        guard let attendanceTimeStamp = attendanceTimeStamp else { return }
        let currentTimeStamp = Date().getTimeStamp()
        let isLate = currentTimeStamp > attendanceTimeStamp
        firebase.attendance(userId: userId, isLate: isLate, timeStamp: currentTimeStamp) { [weak self] result in
            self?.showResult(result: result)
        }
    }
    
    func showResult(result: Bool) {
        let title = result ? "출석 완료" : "출석 실패"
        let message: String? = result ? nil : "QR 코드를 다시 스캔해주세요"
        self.showAlert(title: title, message: message) { [weak self] _ in
            self?.restartScanner()
        }
    }
    
    func restartScanner() {
        if self.captureSession?.isRunning == false {
            self.captureSession.startRunning()
        }
    }
    
    @objc func outQRScanner() {
        self.navigationController?.popViewController(animated: true)
    }
}

extension ScannerViewController: AVCaptureMetadataOutputObjectsDelegate {
    
    func metadataOutput(_ output: AVCaptureMetadataOutput,
                        didOutput metadataObjects: [AVMetadataObject],
                        from connection: AVCaptureConnection
    ) {
        captureSession.stopRunning()
        
        if let metadataObject = metadataObjects.first {
            guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else { return }
            guard let stringValue = readableObject.stringValue else { return }
            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
            processedAttendance(from: stringValue)
        }
        
        if captureSession?.isRunning == true {
            captureSession.stopRunning()
        }
//        dismiss(animated: true)
    }
}
