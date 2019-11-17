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
            let filter = CIFilter(name: "CIQRCodeGenerator"),
            let colorFilter = CIFilter(name: "CIFalseColor") else {
                return nil
        }
        filter.setValue(data, forKey: "inputMessage")
        colorFilter.setValue(filter.outputImage, forKey: "inputImage")
        colorFilter.setValue(CIColor(red: 21 / 255.0, green: 21 / 255.0, blue: 21 / 255.0), forKey: "inputColor1") // Background
        colorFilter.setValue(CIColor(red: 1, green: 1, blue: 1), forKey: "inputColor0") // Foreground
        let transform = CGAffineTransform(scaleX: 3, y: 3)
        
        guard let output = colorFilter.outputImage?.transformed(by: transform) else {
            return nil
        }
        
        return UIImage(ciImage: output)
    }
}
