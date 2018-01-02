//
//  StaticNavigationController.swift
//  StaticNavigationController
//
//  Created by Seth Folley on 12/25/17.
//  Copyright © 2017 Seth Folley. All rights reserved.
//

import UIKit
public enum StaticNavigationPosition {
    case center
    case left
    case right
}

let kStaticNavIndicatorAnimationDuration = 0.3

public class StaticNavigationController: UINavigationController, UINavigationBarDelegate {

    // MARK: Variables
    public var leftBarButtonItem: UIBarButtonItem? {
        didSet {
            leftBarButtonItem?.target = self
            leftBarButtonItem?.action = #selector(leftItemTapped)
            rootViewController.navigationItem.setLeftBarButton(leftBarButtonItem, animated: false)
        }
    }

    public var rightBarButtonItem: UIBarButtonItem? {
        didSet {
            rightBarButtonItem?.target = self
            rightBarButtonItem?.action = #selector(rightItemTapped)
            rootViewController.navigationItem.setRightBarButton(rightBarButtonItem, animated: false)
        }
    }

    public var centerButton: UIButton? {
        didSet {
            centerButton?.addTarget(self, action: #selector(centerItemTapped), for: .touchUpInside)
            rootViewController.navigationItem.titleView = centerButton
        }
    }

    public var leftViewController: UIViewController?
    public var centerViewController = UIViewController() {
        didSet {

        }
    }
    public var rightViewController: UIViewController?

    private var activeViewController: UIViewController?
    var activeViewControllerIsStale = false
    var activePosition = StaticNavigationPosition.center {
        didSet {
            // only update push/pop directions if new value isn't center
            if activePosition != .center {
                pushTransitionDirection = activePosition == .right ? .fromRight : .fromLeft
                popTransitionDirection = activePosition == .right ? .fromLeft : .fromRight
            }
        }
    }

    public var shouldAnimateTransitions = true
    var navigationAnimator = RootAnimator()

    private var pushTransitionDirection = TransitionDirection.fromLeft
    private var popTransitionDirection = TransitionDirection.fromLeft

    public var transitionDuration: TimeInterval = kStaticNavIndicatorAnimationDuration {
        didSet {
            self.navigationAnimator.duration = transitionDuration
        }
    }

    private var navBar: StaticNavigationBar? {
        return navigationBar as? StaticNavigationBar
    }

    private var viewControllerStack: [UIViewController] = [ ]
    private var rootViewController = RootViewController()

    // MARK: Lifecycle
    public convenience init(centerViewController: UIViewController, toolbarClass: AnyClass? = nil) {
        self.init(navigationBarClass: StaticNavigationBar.self, toolbarClass: toolbarClass)

//        view.backgroundColor = UIColor.cyan

        self.centerViewController = centerViewController
        viewControllerStack.append(self.centerViewController)
        activeViewController = centerViewController

        rootViewController.addChildViewController(self.centerViewController)
        rootViewController.currentView = self.centerViewController.view
        setViewControllers([rootViewController], animated: false)
    }

    private override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
    }
    private override init(navigationBarClass: AnyClass?, toolbarClass: AnyClass?) {
        super.init(navigationBarClass: navigationBarClass, toolbarClass: toolbarClass)
    }
    private override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override public func viewDidLoad() {
        super.viewDidLoad()

        navBar?.addSubviews()
    }

    // MARK: Navigation
    // TODO: test pushViewController
    override public func pushViewController(_ viewController: UIViewController, animated: Bool) { print(#function)
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

        viewControllerStack.append(viewController)

        activeViewController = viewController
        activeViewControllerIsStale = false
    }

    // TODO: test popToViewController
    override public func popViewController(animated: Bool) -> UIViewController? { print(#function)
        // Cannot pop vc if there is only 1 left
        guard viewControllerStack.count > 1 else { return nil }

        guard let viewController = viewControllerStack.last else { return nil }

        rootViewController.transition(to: viewController,
                                      direction: popTransitionDirection,
                                      animated: animated,
                                      duration: transitionDuration,
                                      completion:  { _ in
                                        self.updatedNavigation()
                                    })

        let lastVC = viewControllerStack.popLast()
        // if popLast is nil, don't change activeViewController
        if lastVC == nil {
            activeViewController = lastVC ?? activeViewController
            activeViewControllerIsStale = false
        }

        return lastVC
    }

    // TODO: test popToRootViewController
    override public func popToRootViewController(animated: Bool) -> [UIViewController]? { print(#function)
        return popToViewController(centerViewController, animated: animated)
    }

    // TODO: popToViewController
    override public func popToViewController(_ viewController: UIViewController, animated: Bool) -> [UIViewController]? { print(#function)

        guard viewControllerStack.contains(viewController),
              let index = viewControllerStack.index(of: viewController)
            else { return nil }



        if activeViewController != viewController {
            var transitionDirection = popTransitionDirection
            if activeViewControllerIsStale {
                transitionDirection = pushTransitionDirection
            }
            rootViewController.transition(to: viewController,
                                          direction: transitionDirection,
                                          animated: animated,
                                          duration: transitionDuration,
                                          completion: { _ in
                                            self.updatedNavigation()
                                       })

            activeViewController = viewController
        } else {
            updatedNavigation()
        }

        let removedVCs = viewControllerStack.removeAll(after: index)

        return removedVCs
    }

    // MARK: Navigation Bar Items' Selectors
    @objc private func leftItemTapped() { print(#function)
        guard let leftVC = leftViewController else { return }
        guard activeViewController != leftVC else { return }

        navBar?.leftItemSelected()

        if activePosition == .left {
            let _ = popToViewController(leftVC, animated: shouldAnimateTransitions)
        } else {
            activePosition = .left
            activeViewControllerIsStale = true
            let _ = popToRootViewController(animated: shouldAnimateTransitions)
            return
        }
    }

    @objc private func centerItemTapped()  { print(#function)
        activePosition = .center

        navBar?.centerItemSelected()

        let _ = popToRootViewController(animated: shouldAnimateTransitions)
    }

    @objc private func rightItemTapped() { print(#function)
        guard let rightVC = rightViewController else { return }
        guard activeViewController != rightVC else { return }

        navBar?.rightItemSelected()

        if activePosition == .right {
            let _ = popToViewController(rightVC, animated: shouldAnimateTransitions)
        } else {
            activePosition = .right
            activeViewControllerIsStale = true
            let _ = popToRootViewController(animated: shouldAnimateTransitions)
            return
        }
    }

    private func initialContainerViewFrame() -> CGRect {
        var frame = CGRect.zero
        frame.origin.y = 44 + UIApplication.shared.statusBarFrame.height
        frame.size.width = view.bounds.width
        frame.size.height = view.bounds.height - frame.origin.y
        return frame
    }

    private func updatedNavigation() {
        guard activeViewController != nil else { return }
        if activeViewControllerIsStale {
            switch activePosition {
            case .left:
                if let leftVC = self.leftViewController {
                    self.pushViewController(leftVC, animated: self.shouldAnimateTransitions)
                }
                break
            case .right:
                if let rightVC = self.rightViewController {
                    self.pushViewController(rightVC, animated: self.shouldAnimateTransitions)
                }
                break
            case .center:
                break
            }
        }
    }
}
