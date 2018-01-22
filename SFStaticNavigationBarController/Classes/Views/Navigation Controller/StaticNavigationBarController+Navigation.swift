//
//  StaticNavigationBarController+Navigation.swift
//  SFStaticNavigationBarController
//
//  Created by Seth Folley on 1/21/18.
//

import Foundation
import UIKit

extension StaticNavigationBarController {
    // MARK: Navigation
    override public func pushViewController(_ viewController: UIViewController, animated: Bool) {
        guard !isTransitioning else {
            print("\(#function) failed because StaticNavigationBarController is currently transitioning.")
            return
        }
        guard activePosition != .center,
            activeViewController != viewController
            else {
                print("\(#function) failed because you are either trying to re-push the activeViewController or the activePosition is StaticNavigationPosition.center.")
                return
        }

        isTransitioning = true
        rootViewController.transition(to: viewController,
                                      direction: pushTransitionDirection,
                                      animated: animated,
                                      duration: transitionDuration,
                                      completion: { [weak self] _ in
                                        self?.isTransitioning = false
                                    })
        staticNavigationBar?.moveSlider(to: activePosition)

        viewControllerStack.append(viewController)
        activeViewController = viewController
    }

    override public func popViewController(animated: Bool) -> UIViewController? {
        guard !isTransitioning else {
            print("\(#function) failed because StaticNavigationBarController is currently transitioning.")
            return nil
        }
        guard viewControllerStack.count > 1 else { return nil }

        let poppedVC = viewControllerStack.popLast()

        guard let viewController = viewControllerStack.last else { return nil }

        if viewControllerStack.count == 1 {
            activePosition = .center
        }

        isTransitioning = true
        rootViewController.transition(to: viewController,
        /*                           */direction: popTransitionDirection,
        /*                           */animated: animated,
        /*      ^--------^           */duration: transitionDuration,
                                       /*       |｡◕‿‿◕｡|            */completion: { [weak self] _ in
                                        self?.isTransitioning = false
                                    })
        staticNavigationBar?.moveSlider(to: activePosition)

        activeViewController = viewController

        return poppedVC
    }

    override public func popToRootViewController(animated: Bool) -> [UIViewController]? {
        guard !isTransitioning else {
            print("\(#function) failed because StaticNavigationBarController is currently transitioning.")
            return nil
        }

        activePosition = .center

        return popToViewController(centerViewController, animated: animated)
    }

    override public func popToViewController(_ viewController: UIViewController, animated: Bool) -> [UIViewController]? {
        guard !isTransitioning else {
            print("\(#function) failed because StaticNavigationBarController is currently transitioning.")
            return nil
        }
        guard viewControllerStack.contains(viewController),
            let index = viewControllerStack.index(of: viewController)
            else { return nil }

        let removedVCs = viewControllerStack.removeAll(after: index)

        isTransitioning = true
        rootViewController.transition(to: viewController,
                                      direction: popTransitionDirection,
                                      animated: animated,
                                      duration: transitionDuration,
                                      completion: { [weak self] _ in
                                        self?.isTransitioning = false
                                    })
        staticNavigationBar?.moveSlider(to: activePosition)

        activeViewController = viewController

        return removedVCs
    }

    internal func navigateAcross(to viewController: UIViewController) {
        guard !isTransitioning else {
            print("\(#function) failed because StaticNavigationBarController is currently transitioning.")
            return
        }

        viewControllerStack.removeAll(after: 0)

        isTransitioning = true
        rootViewController.transition(to: viewController,
                                      middle: shouldAnimateAcrossCenter ? centerViewController : nil,
                                      direction: pushTransitionDirection,
                                      animated: shouldAnimateTransitions,
                                      duration: transitionDuration,
                                      completion: { [weak self] _ in
                                        self?.isTransitioning = false
                                    })
        staticNavigationBar?.moveSlider(to: activePosition)

        activeViewController = viewController
        viewControllerStack.append(viewController)
    }
}
