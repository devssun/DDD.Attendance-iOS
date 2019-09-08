//
//  InteractiveTransitionableViewController.swift
//  DDD.Attendance
//
//  Created by seongjun.park on 08/09/2019.
//  Copyright © 2019 DDD. All rights reserved.
//

import UIKit

protocol InteractiveTransitionableViewController {
    
    var interactivePresentTransition: InteractiveAnimator? { get }
    
    var interactiveDismissTransition: InteractiveAnimator? { get }
}
