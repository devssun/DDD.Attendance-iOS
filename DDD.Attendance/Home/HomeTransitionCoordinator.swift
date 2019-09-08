//
//  TransitionCoordinator.swift
//  DDD.Attendance
//
//  Created by seongjun.park on 08/09/2019.
//  Copyright © 2019 DDD. All rights reserved.
//

import UIKit

class HomeTransitionCoordinator: NSObject {

    var toViewController: AccountViewController?
    lazy var toViewControllerInitalYPosition: CGFloat = {
        let bottomTriggerViewHeight: CGFloat = fromViewControllerGestureView?.frame.height ?? 0
        let accountViewYPosition = toViewController?.accountView.frame.minY ?? 0
        let y = bottomTriggerViewHeight + accountViewYPosition
        return y
    }()
    
    var interactivePresentTransition: InteractiveAnimator?
    var interactiveDismissTransition: InteractiveAnimator?
    var fromViewControllerGestureView: UIView?
    
    func prepareViewforCustomTransition(fromViewController: HomeViewController, with data: AccountModel) {
        if toViewController != nil { return }
        let toViewController = AccountViewController.instantiateViewController()
        toViewController.transitioningDelegate = self
        toViewController.modalPresentationStyle = .custom
        toViewController.accountModel = data
        
        interactivePresentTransition = InteractiveAnimator(fromViewController: fromViewController,
                                                           toViewController: toViewController,
                                                           gestureView: fromViewController.bottomTriggerView)
        interactiveDismissTransition = InteractiveAnimator(fromViewController: toViewController,
                                                           toViewController: nil,
                                                           gestureView: toViewController.view)
        
        self.toViewController = toViewController
        self.fromViewControllerGestureView = fromViewController.bottomTriggerView
    }
    
    func removeCustomTransitionBehaviour() {
        interactivePresentTransition = nil
        interactiveDismissTransition = nil
        toViewController = nil
    }
}

extension HomeTransitionCoordinator: UIViewControllerTransitioningDelegate {
    
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
