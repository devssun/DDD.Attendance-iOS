//
//  ImageScrollView.swift
//  DDD.Attendance
//
//  Created by 최혜선 on 2020/07/11.
//  Copyright © 2020 DDD. All rights reserved.
//

import UIKit

class ImageScrollViewController: BaseViewController {
    @IBOutlet fileprivate weak var imageView: UIImageView!
    @IBOutlet fileprivate weak var scrollView: UIScrollView!
    
    var zoomImage: UIImage?
    
    static func instantiateViewController() -> ImageScrollViewController {
        return Storyboard.home.viewController(ImageScrollViewController.self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        imageView.image = zoomImage
    }
}

extension ImageScrollViewController: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.imageView
    }
}
