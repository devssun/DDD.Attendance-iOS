//
//  PosterCell.swift
//  DDD.Attendance
//
//  Created by ParkSungJoon on 10/10/2019.
//  Copyright © 2019 DDD. All rights reserved.
//

import UIKit

class PosterCell: UICollectionViewCell, BaseCell {
    
    static var defaultReusableId: String = "PosterCell"
    
    @IBOutlet private weak var posterImageView: UIImageView!
    @IBOutlet private weak var posterTitleLabel: UILabel!
    @IBOutlet private weak var posterDescriptionLabel: UILabel!
    
    func configureWith(value: PosterModel) {
        posterImageView.image = value.poster
        posterTitleLabel.text = value.title
        posterDescriptionLabel.text = value.description
    }
}
