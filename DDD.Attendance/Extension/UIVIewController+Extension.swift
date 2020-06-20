//
//  UIVIewController+Extension.swift
//  DDD.Attendance
//
//  Created by ParkSungJoon on 19/10/2019.
//  Copyright © 2019 DDD. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func showAlert(title: String,
                   message: String?,
                   handler: ((UIAlertAction) -> Swift.Void)? = nil
    ) {
        DispatchQueue.main.async { [unowned self] in
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: handler))
            self.present(alertController, animated: true, completion: nil)
        }
    }
}
