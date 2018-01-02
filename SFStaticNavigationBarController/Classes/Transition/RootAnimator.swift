//
//  RootAnimatedTransitioning.swift
//  CurtsyDating
//
//  Created by Seth Folley on 8/7/17.
//  Copyright © 2017 Curtsy. All rights reserved.
//

import Foundation
import UIKit

class RootAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    var duration = 0.3
    var presenting = true
    var originFrame = CGRect.zero
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        guard let toVC = transitionContext.viewController(forKey: .to),
            let fromVC = transitionContext.viewController(forKey: .from) else { return }
        
        toVC.view.frame = transitionContext.initialFrame(for: toVC)
        toVC.view.clipsToBounds = true
        
        containerView.addSubview(toVC.view)
        containerView.bringSubview(toFront: toVC.view)
        
        toVC.beginAppearanceTransition(true, animated: duration > 0)
        fromVC.beginAppearanceTransition(false, animated: duration > 0)
        
        UIView.animate(withDuration: duration, animations: {
            toVC.view.frame = transitionContext.finalFrame(for: toVC)
            fromVC.view.frame = transitionContext.finalFrame(for: fromVC)
        }) { _ in
            toVC.endAppearanceTransition()
            fromVC.endAppearanceTransition()
            transitionContext.completeTransition(true)
        }
    }
    
    func animationEnded(_ transitionCompleted: Bool) {
        
    }
}
