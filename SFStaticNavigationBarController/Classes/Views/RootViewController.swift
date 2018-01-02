//
//  RootViewController.swift
//  Pods-SFStaticNavigationBarController_Example
//
//  Created by Seth Folley on 1/1/18.
//

import UIKit

class RootViewController: UIViewController {
    private lazy var containerView: UIView = {
        let view = UIView(frame: self.view.bounds)
        let statusBarHeight = UIApplication.shared.statusBarFrame.height
        let height = view.frame.height - statusBarHeight - 44
        view.frame.size.height = height
//        view.backgroundColor = .purple
//        view.layer.borderColor = UIColor.white.cgColor
//        view.layer.borderWidth = 3
        return view
    }()

    var currentView: UIView?

    private var transitionAnimator = RootAnimator()

    override func viewDidLoad() {
        super.viewDidLoad()
//        view.backgroundColor = .brown
        view.addSubview(containerView)

        if let view = currentView {
            view.frame = containerView.frame
            view.frame.origin = .zero
            containerView.addSubview(view)
        }
    }

    func transition(to viewController: UIViewController, direction: TransitionDirection,
                    animated: Bool, duration: Double, completion: ((Bool) -> Void)?) {
        
        guard let fromVC = self.childViewControllers.last else {
            self.addChildViewController(viewController)
            self.containerView.addSubview(viewController.view)
            viewController.didMove(toParentViewController: self)
            return
        }

        fromVC.willMove(toParentViewController: nil)
        if !self.childViewControllers.contains(viewController) {
            self.addChildViewController(viewController)
        }


        let transitionContext = RootTransitionContext(from: fromVC, to: viewController, direction: direction)
        transitionContext.isAnimated = animated
        transitionContext.isInteractive = false
        transitionContext.completionBlock = { didComplete in
            fromVC.view.removeFromSuperview()
            fromVC.removeFromParentViewController()
            viewController.didMove(toParentViewController: self)
            self.transitionAnimator.animationEnded(didComplete)
            completion?(didComplete)
        }

        transitionAnimator.duration = Double(duration)
        transitionAnimator.animateTransition(using: transitionContext)
    }
}
