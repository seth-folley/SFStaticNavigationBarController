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
    var middleViewController: UIViewController?

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard middleViewController == nil else {
            multipleViewControllerAnimation(using: transitionContext)
            return
        }

        guard let toVC = transitionContext.viewController(forKey: .to),
            let fromVC = transitionContext.viewController(forKey: .from) else { return }

        let containerView = transitionContext.containerView

        toVC.view.frame = transitionContext.initialFrame(for: toVC)
        toVC.view.clipsToBounds = true
        
        containerView.addSubview(toVC.view)
        containerView.bringSubview(toFront: toVC.view)

        UIView.animate(withDuration: duration, animations: {
            toVC.view.frame = transitionContext.finalFrame(for: toVC)
            fromVC.view.frame = transitionContext.finalFrame(for: fromVC)
        }) { _ in
            transitionContext.completeTransition(true)
        }
    }

    private func multipleViewControllerAnimation(using transitionContext: UIViewControllerContextTransitioning) {
        guard let middleVC = middleViewController,
            let toVC = transitionContext.viewController(forKey: .to),
            let fromVC = transitionContext.viewController(forKey: .from) else { return }

        let containerView = transitionContext.containerView

        middleVC.view.frame = transitionContext.initialFrame(for: toVC)
        middleVC.view.clipsToBounds = true
        toVC.view.frame = transitionContext.initialFrame(for: toVC)
        toVC.view.clipsToBounds = true

        containerView.addSubview(middleVC.view)
        containerView.addSubview(toVC.view)
        containerView.bringSubview(toFront: toVC.view)

        let middleMiddleFrame = transitionContext.finalFrame(for: toVC)
        let middleFinalFrame = transitionContext.finalFrame(for: fromVC)


        UIView.animateKeyframes(withDuration: duration, delay: 0, options: .calculationModeLinear, animations: {
            // Animate first vc leaving and middle vc passing
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.5, animations: {
                fromVC.view.frame = transitionContext.finalFrame(for: fromVC)
                middleVC.view.frame = middleMiddleFrame
            })
            // Animate middle vc leaving and final vc
            UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.5, animations: {
                middleVC.view.frame = middleFinalFrame
                toVC.view.frame = transitionContext.finalFrame(for: toVC)
            })
        }) /* completion: */ { [weak self] _ in
            transitionContext.completeTransition(true)
            self?.middleViewController = nil
        }
    }

    func animationEnded(_ transitionCompleted: Bool) {
        
    }
}
