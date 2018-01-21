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
        guard activePosition != .center,
            activeViewController != viewController
            else {
                print("\(#function) failed because you are either trying to re-push the activeViewController or the activePosition is StaticNavigationPosition.center.")
                return
        }

        rootViewController.transition(to: viewController,
                                      direction: pushTransitionDirection,
                                      animated: animated,
                                      duration: transitionDuration,
                                      completion: nil)
        staticNavigationBar?.moveSlider(to: activePosition)

        viewControllerStack.append(viewController)
        activeViewController = viewController
    }

    override public func popViewController(animated: Bool) -> UIViewController? {
        // Cannot pop vc if there is only 1 left
        guard viewControllerStack.count > 1 else { return nil }

        let poppedVC = viewControllerStack.popLast()

        guard let viewController = viewControllerStack.last else { return nil }

        if viewControllerStack.count == 1 {
            activePosition = .center
        }

        rootViewController.transition(to: viewController,
        /*                           */direction: popTransitionDirection,
        /*                           */animated: animated,
        /*      ^--------^           */duration: transitionDuration,
        /*       |｡◕‿‿◕｡|            */completion: nil)
        staticNavigationBar?.moveSlider(to: activePosition)

        activeViewController = viewController

        return poppedVC
    }

    override public func popToRootViewController(animated: Bool) -> [UIViewController]? {
        activePosition = .center

        return popToViewController(centerViewController, animated: animated)
    }

    override public func popToViewController(_ viewController: UIViewController, animated: Bool) -> [UIViewController]? {
        guard viewControllerStack.contains(viewController),
            let index = viewControllerStack.index(of: viewController)
            else { return nil }

        let removedVCs = viewControllerStack.removeAll(after: index)

        rootViewController.transition(to: viewController,
                                      direction: popTransitionDirection,
                                      animated: animated,
                                      duration: transitionDuration,
                                      completion: nil)
        staticNavigationBar?.moveSlider(to: activePosition)

        activeViewController = viewController

        return removedVCs
    }

    internal func navigateAcross(to viewController: UIViewController) {
        viewControllerStack.removeAll(after: 0)

        rootViewController.transition(to: viewController,
                                      middle: centerViewController,
                                      direction: pushTransitionDirection,
                                      animated: true,
                                      duration: transitionDuration,
                                      completion: nil)
        activeViewController = viewController
        viewControllerStack.append(viewController)
    }
}
