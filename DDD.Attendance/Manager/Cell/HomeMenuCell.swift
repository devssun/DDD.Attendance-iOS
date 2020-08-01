//
//  HomeMenuCell.swift
//  DDD.Attendance
//
//  Created by 최혜선 on 2020/07/12.
//  Copyright © 2020 DDD. All rights reserved.
//

import UIKit

class HomeMenuCell: UITableViewCell, BaseCell {
    
    static var defaultReusableId: String = "HomeMenuCell"
    
    @IBOutlet fileprivate weak var containerView: UIView!
    @IBOutlet fileprivate weak var titleLabel: UILabel!
    @IBOutlet fileprivate weak var subTitleLabel: UILabel!
    @IBOutlet fileprivate weak var iconImageView: UIImageView!
    @IBOutlet fileprivate weak var iconBackgroundView: UIView!

    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
        subTitleLabel.text = nil
        iconImageView.image = nil
        iconBackgroundView.backgroundColor = .white
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        containerView.then {
            $0.layer.cornerRadius = 15.0
            $0.layer.borderWidth = 2.0
            $0.layer.borderColor = UIColor(red: 152.0/255, green: 152.0/255, blue: 152.0/255, alpha: 1.0).cgColor
            $0.layer.shadowColor = UIColor(red: 224.0/255, green: 224.0/255, blue: 224.0/255, alpha: 1.0).cgColor
            $0.layer.shadowOpacity = 2
            $0.layer.shadowOffset = .zero
        }
        
        iconBackgroundView.then {
            $0.clipsToBounds = true
            $0.layer.cornerRadius = $0.frame.width / 2
        }
    }
    
    func configureWith(value: MenuModel) {
        titleLabel.text = value.title
        subTitleLabel.text = value.subTitle
        iconImageView.image = UIImage(named: value.iconName)
        iconBackgroundView.backgroundColor =
            value.iconName == "hiclipartCom1" ?
                UIColor(red: 188.0/255, green: 213.0/255, blue: 244.0/255, alpha: 1.0) : UIColor(red: 254.0/255, green: 210.0/255, blue: 59.0/255, alpha: 1.0)
    }
}
