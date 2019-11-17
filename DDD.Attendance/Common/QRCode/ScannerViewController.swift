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
        
        navigationItem.setRightBarButton(UIBarButtonItem(barButtonSystemItem: .cancel,
                                                         target: self,
                                                         action: #selector(signOut)), animated: true)
        
        captureSession.startRunning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if captureSession?.isRunning == false {
            captureSession.startRunning()
        }
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
    
    func found(code: String) {
        showAlert(title: "출석 완료", message: code) { [weak self] _ in
            if self?.captureSession?.isRunning == false {
                self?.captureSession.startRunning()
            }
        }
    }
    
    @objc func signOut() {
        firebase.signOut { [weak self] isSuccess in
            if isSuccess {
                let loginVC = LoginViewController.instantiateViewController()
                UIApplication.shared.keyWindow?.rootViewController = loginVC
            } else {
                self?.showAlert(title: "로그아웃 실패", message: "로그아웃에 실패하였습니다.")
            }
        }
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
            found(code: stringValue)
        }
        
        if captureSession?.isRunning == true {
            captureSession.stopRunning()
        }
//        dismiss(animated: true)
    }
}
