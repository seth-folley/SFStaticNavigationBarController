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

public class StaticNavigationBarController: UINavigationController {

    // MARK: Navigation Bar Items
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

    public var centerItem: UIView? {
        didSet {
            let tap = UITapGestureRecognizer(target: self, action: #selector(centerItemTapped))
            centerItem?.addGestureRecognizer(tap)
            rootViewController.navigationItem.titleView = centerItem
        }
    }

    // MARK: View Controller variables
    public var leftViewController: UIViewController?
    public var centerViewController = UIViewController()
    public var rightViewController: UIViewController?

    // MARK: Active variables
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

    // MARK: Transition variables
    public var shouldAnimateTransitions = true
    var navigationAnimator = RootAnimator()

    private var pushTransitionDirection = TransitionDirection.fromLeft
    private var popTransitionDirection = TransitionDirection.fromLeft

    public var transitionDuration: TimeInterval = kStaticNavIndicatorAnimationDuration {
        didSet {
            self.navigationAnimator.duration = transitionDuration
        }
    }

    public var staticNavigationBar: StaticNavigationBar? {
        get {
            return navigationBar as? StaticNavigationBar
        }
    }

    private var viewControllerStack: [UIViewController] = [ ]
    private var rootViewController = SFRootViewController()

    // MARK: Lifecycle
    public convenience init(centerViewController: UIViewController, toolbarClass: AnyClass? = nil) {
        self.init(navigationBarClass: StaticNavigationBar.self, toolbarClass: toolbarClass)

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

        staticNavigationBar?.addSubviews()
    }

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

        viewControllerStack.append(viewController)

        staticNavigationBar?.moveSlider(to: activePosition)

        activeViewController = viewController
        activeViewControllerIsStale = false
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
                                      direction: popTransitionDirection,
                                      animated: animated,
                                      duration: transitionDuration,
                                      completion:  { _ in
                                        self.updatedNavigation()
                                    })

        staticNavigationBar?.moveSlider(to: activePosition)

        activeViewController = viewController
        activeViewControllerIsStale = false

        return poppedVC
    }

    override public func popToRootViewController(animated: Bool) -> [UIViewController]? {
        if !activeViewControllerIsStale {
            activePosition = .center
        }

        return popToViewController(centerViewController, animated: animated)
    }

    override public func popToViewController(_ viewController: UIViewController, animated: Bool) -> [UIViewController]? {

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

            staticNavigationBar?.moveSlider(to: activePosition)

            activeViewController = viewController
        } else {
            updatedNavigation()
        }

        let removedVCs = viewControllerStack.removeAll(after: index)

        return removedVCs
    }

   // MARK: Navigation Bar Items' Selectors
    @objc private func leftItemTapped() {
        guard let leftVC = leftViewController else { return }
        guard activeViewController != leftVC else { return }

        staticNavigationBar?.leftItemSelected()

        if activePosition == .left {
            let _ = popToViewController(leftVC, animated: shouldAnimateTransitions)
        } else {
            activePosition = .left
            activeViewControllerIsStale = true
            let _ = popToRootViewController(animated: shouldAnimateTransitions)
            return
        }
    }

    @objc private func centerItemTapped()  {
        activePosition = .center

        staticNavigationBar?.centerItemSelected()

        let _ = popToRootViewController(animated: shouldAnimateTransitions)
    }

    @objc private func rightItemTapped() {
        guard let rightVC = rightViewController else { return }
        guard activeViewController != rightVC else { return }

        staticNavigationBar?.rightItemSelected()

        if activePosition == .right {
            let _ = popToViewController(rightVC, animated: shouldAnimateTransitions)
        } else {
            activePosition = .right
            activeViewControllerIsStale = true
            let _ = popToRootViewController(animated: shouldAnimateTransitions)
            return
        }
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
