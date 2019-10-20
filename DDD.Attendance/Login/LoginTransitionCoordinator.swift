//
//  LoginTransitionCoordinator.swift
//  DDD.Attendance
//
//  Created by ParkSungJoon on 15/09/2019.
//  Copyright © 2019 DDD. All rights reserved.
//

import UIKit

class LoginTransitionCoordinator: NSObject {
    
    private lazy var toViewControllerInitalYPosition: CGFloat = {
        let loginPopupViewYPosition = toViewController?.loginPopupView.frame.minY ?? 0
        return loginPopupViewYPosition
    }()
    
    var toViewController: LoginPopupViewController?
    var interactivePresentTransition: InteractiveAnimator?
    var interactiveDismissTransition: InteractiveAnimator?
    var fromViewControllerGestureView: UIView?
    
    func prepareViewforCustomTransition(fromViewController: LoginViewController) {
        if toViewController != nil { return }
        let toViewController = LoginPopupViewController.instantiateViewController()
        toViewController.transitioningDelegate = self
        toViewController.modalPresentationStyle = .custom
        
        interactivePresentTransition = InteractiveAnimator(fromViewController: fromViewController,
                                                           toViewController: toViewController,
                                                           gestureView: UIView())
        interactiveDismissTransition = InteractiveAnimator(fromViewController: fromViewController,
                                                           toViewController: nil,
                                                           gestureView: toViewController.view)
        self.toViewController = toViewController
        self.fromViewControllerGestureView = UIView()
    }
    
    func removeCustomTransitionBehaviour() {
        interactivePresentTransition = nil
        interactiveDismissTransition = nil
        toViewController = nil
    }
}

extension LoginTransitionCoordinator: UIViewControllerTransitioningDelegate {
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return PresentingViewAnimator(initialY: toViewControllerInitalYPosition)
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return DismissingViewAnimator(initialY: toViewControllerInitalYPosition)
    }
    
    func interactionControllerForPresentation(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        guard
            let presentInteractor = interactivePresentTransition,
            presentInteractor.isTransitionInProcess else {
                return nil
        }
        return presentInteractor
    }
    
    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        guard
            let dismissInteractor = interactiveDismissTransition,
            dismissInteractor.isTransitionInProcess else {
                return nil
        }
        return dismissInteractor
    }
}
