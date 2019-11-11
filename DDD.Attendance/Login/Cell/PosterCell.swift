//
//  PosterCell.swift
//  DDD.Attendance
//
//  Created by ParkSungJoon on 10/10/2019.
//  Copyright © 2019 DDD. All rights reserved.
//

import UIKit
import Lottie

class PosterCell: UICollectionViewCell, BaseCell {
    
    static var defaultReusableId: String = "PosterCell"
    
    
    @IBOutlet private weak var posterAnimationView: AnimationView!
    @IBOutlet private weak var posterTitleLabel: UILabel!
    @IBOutlet private weak var posterDescriptionLabel: UILabel!
    
    func configureWith(value: PosterModel) {
        posterAnimationView.animation = Animation.named(value.poster)
        posterTitleLabel.text = value.title
        posterDescriptionLabel.text = value.description
        posterAnimationView.play()
    }
}

// MARK: - Private
private extension PosterCell {
}
