//
//  BannerModel.swift
//  DDD.Attendance
//
//  Created by 최혜선 on 2020/06/25.
//  Copyright © 2020 DDD. All rights reserved.
//

import Foundation

struct Banner: Codable {
    let title: String
    let subTitle: String
    let imageData: Data?
}
