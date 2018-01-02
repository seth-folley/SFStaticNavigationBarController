//
//  RootTranstionContext.swift
//  CurtsyDating
//
//  Created by Seth Folley on 8/6/17.
//  Copyright © 2017 Curtsy. All rights reserved.
//

import Foundation
import UIKit

enum TransitionDirection {
    case fromRight
    case fromLeft
}

class RootTransitionContext: NSObject, UIViewControllerContextTransitioning {
    var viewControllers: [UITransitionContextViewControllerKey:  UIViewController]
    var containerView: UIView
    var isAnimated: Bool = true
    var isInteractive: Bool = false//{ get } // This indicates whether the transition is currently interactive.
    var transitionWasCancelled: Bool = false//{ get }
    var presentationStyle: UIModalPresentationStyle = .custom //{ get }
    var targetTransform: CGAffineTransform = CGAffineTransform()//{ get }

    var completionBlock: ((_ didComplete: Bool) -> Void)? = nil
    
    private var disappearingFromRect: CGRect
    private var appearingFromRect: CGRect
    private var disappearingToRect: CGRect
    private var appearingToRect: CGRect
    
    init(from fVC: UIViewController, to tVC: UIViewController, direction: TransitionDirection) {
        guard let superView = fVC.view.superview, fVC.isViewLoaded else {
            fatalError("View is not ready")
        }

        self.viewControllers = [UITransitionContextViewControllerKey.from: fVC, UITransitionContextViewControllerKey.to: tVC]
        self.containerView = superView
        
        let isTransitioningRight = direction == .fromLeft
        let dx = (isTransitioningRight ? self.containerView.bounds.width : -self.containerView.bounds.width)
        disappearingFromRect = self.containerView.bounds
        appearingToRect = self.containerView.bounds
        disappearingToRect = self.containerView.bounds.offsetBy(dx: dx, dy: 0)
        appearingFromRect = self.containerView.bounds.offsetBy(dx: -dx, dy: 0)
    }

    // The next two values can change if the animating transition is interruptible.
    // This indicates whether the transition is currently interactive.
    
    // An interaction controller that conforms to the
    // UIViewControllerInteractiveTransitioning protocol (which is vended by a
    // container view controller's delegate or, in the case of a presentation, the
    // transitioningDelegate) should call these methods as the interactive
    // transition is scrubbed and then either cancelled or completed. Note that if
    // the animator is interruptible, then calling finishInteractiveTransition: and
    // cancelInteractiveTransition: are indications that if the transition is not
    // interrupted again it will finish naturally or be cancelled.
    
    func updateInteractiveTransition(_ percentComplete: CGFloat) {
        
    }
    
    func finishInteractiveTransition() {
        
    }
    
    func cancelInteractiveTransition() {
        
    }
    
    
    // This should be called if the transition animation is interruptible and it
    // is being paused.
    @available(iOS 10.0, *)
    func pauseInteractiveTransition() {
        
    }
    
    
    // This must be called whenever a transition completes (or is cancelled.)
    // Typically this is called by the object conforming to the
    // UIViewControllerAnimatedTransitioning protocol that was vended by the transitioning
    // delegate.  For purely interactive transitions it should be called by the
    // interaction controller. This method effectively updates internal view
    // controller state at the end of the transition.
    func completeTransition(_ didComplete: Bool) {
        completionBlock?(didComplete)
    }
    
    
    // Currently only two keys are defined by the
    // system - UITransitionContextToViewControllerKey, and
    // UITransitionContextFromViewControllerKey.
    // Animators should not directly manipulate a view controller's views and should
    // use viewForKey: to get views instead.
    func viewController(forKey key: UITransitionContextViewControllerKey) -> UIViewController? {
        guard let vcForKey = self.viewControllers[key] else { return nil }
        return vcForKey
    }
    
    
    // Currently only two keys are defined by the system -
    // UITransitionContextFromViewKey, and UITransitionContextToViewKey
    // viewForKey: may return nil which would indicate that the animator should not
    // manipulate the associated view controller's view.
    func view(forKey key: UITransitionContextViewKey) -> UIView? {
        return nil
    }
    
    // The frame's are set to CGRectZero when they are not known or
    // otherwise undefined.  For example the finalFrame of the
    // fromViewController will be CGRectZero if and only if the fromView will be
    // removed from the window at the end of the transition. On the other
    // hand, if the finalFrame is not CGRectZero then it must be respected
    // at the end of the transition.
    func initialFrame(for vc: UIViewController) -> CGRect {
        if vc == self.viewControllers[.from] {
            return self.disappearingFromRect
        } else {
            return self.appearingFromRect
        }
    }
    
    func finalFrame(for vc: UIViewController) -> CGRect {
        if vc == self.viewControllers[.from] {
            return self.disappearingToRect
        } else {
            return self.appearingToRect
        }
    }
}
