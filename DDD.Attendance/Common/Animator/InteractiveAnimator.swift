//
//  InteractiveAnimator.swift
//  DDD.Attendance
//
//  Created by seongjun.park on 08/09/2019.
//  Copyright © 2019 DDD. All rights reserved.
//

import UIKit

class InteractiveAnimator: UIPercentDrivenInteractiveTransition {
    
    let fromViewController: UIViewController
    let toViewController: UIViewController?
    var isTransitionInProcess = false
    var isEnabled = true {
        didSet {
            panGestureRecognizer.isEnabled = isEnabled
        }
    }
    
    private var shouldComplete = false
    private let threshold: CGFloat = 0.3
    private let targetScreenHeight = UIScreen.main.bounds.height - 150
    
    private lazy var dragAmount = toViewController == nil ? targetScreenHeight : -targetScreenHeight
    private lazy var panGestureRecognizer: UIPanGestureRecognizer = {
        let pan = UIPanGestureRecognizer()
        pan.addTarget(self, action: #selector(handlePanGestureRecognizer))
        return pan
    }()
    
    init(fromViewController: UIViewController, toViewController: UIViewController?, gestureView: UIView) {
        self.fromViewController = fromViewController
        self.toViewController = toViewController
        super.init()
        gestureView.addGestureRecognizer(self.panGestureRecognizer)
        completionSpeed = 0.6
    }
    
    deinit {
        panGestureRecognizer.view?.removeGestureRecognizer(panGestureRecognizer)
    }
}

// MARK: - Private
private extension InteractiveAnimator {
    
    @objc func handlePanGestureRecognizer(_ panGestureRecognizer: UIPanGestureRecognizer) {
        let translation = panGestureRecognizer.translation(in: panGestureRecognizer.view?.superview)
        
        switch panGestureRecognizer.state {
        case .began:
            isTransitionInProcess = true
            if let toViewController = toViewController {
                fromViewController.present(toViewController, animated: true, completion: nil)
            } else {
                fromViewController.dismiss(animated: true, completion: nil)
            }
        case .changed:
            isTransitionInProcess = true
            var percent = translation.y / dragAmount
            percent = fmax(percent, 0)
            percent = fmin(percent, 1)
            update(percent)
            
            shouldComplete = percent > threshold
            
            if shouldComplete {
                (fromViewController as? Animatable)?.prepareBeingDismissed()
                finish()
            }
        case .ended:
            shouldComplete ? finish() : cancel()
            isTransitionInProcess = false
        case .cancelled:
            cancel()
            isTransitionInProcess = false
        default:
            isTransitionInProcess = false
        }
    }
}
