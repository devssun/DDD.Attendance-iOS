//
//  QRCodeController.swift
//  DDD.Attendance
//
//  Created by ParkSungJoon on 01/09/2019.
//  Copyright © 2019 DDD. All rights reserved.
//

import UIKit

class QRCodeController {
    
    static func generate(from uid: String) -> UIImage? {
        let data = uid.data(using: String.Encoding.ascii)

        guard
            let filter = CIFilter(name: "CIQRCodeGenerator") else {
                return nil
        }
        filter.setValue(data, forKey: "inputMessage")
        let transform = CGAffineTransform(scaleX: 3, y: 3)
        
        guard let output = filter.outputImage?.transformed(by: transform) else {
            return nil
        }
        
        return UIImage(ciImage: output)
    }
}
