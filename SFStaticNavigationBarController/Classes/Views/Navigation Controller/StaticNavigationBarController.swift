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
    public var staticNavigationBar: StaticNavigationBar? {
        get {
            return navigationBar as? StaticNavigationBar
        }
    }

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

    internal var viewControllerStack: [UIViewController] = [ ]
    internal var rootViewController = SFRootViewController()

    // MARK: Active variables
    internal var activeViewController: UIViewController?
    internal var activePosition = StaticNavigationPosition.center {
        didSet {
            if activePosition != .center {
                pushTransitionDirection = activePosition == .right ? .fromRight : .fromLeft
                popTransitionDirection = activePosition == .right ? .fromLeft : .fromRight
            }
        }
    }

    // MARK: Transition variables
    public var shouldAnimateTransitions = true

    internal var isTransitioning = false

    internal var pushTransitionDirection = TransitionDirection.fromLeft
    internal var popTransitionDirection = TransitionDirection.fromLeft

    public var transitionDuration: TimeInterval = kStaticNavIndicatorAnimationDuration

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

    override public func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        staticNavigationBar?.updateSliderDetails(animated: false)
    }

   // MARK: Navigation Bar Items' Selectors
    @objc private func leftItemTapped() {
        guard !isTransitioning,
              let leftVC = leftViewController,
              activeViewController != leftVC else { return }

        let previousPosition = activePosition
        activePosition = .left

        switch previousPosition {
        case .left:
            let _ = popToViewController(leftVC, animated: shouldAnimateTransitions)
        case .right:
            navigateAcross(to: leftVC)
            return
        case .center:
            pushViewController(leftVC, animated: shouldAnimateTransitions)
        }
    }

    @objc private func centerItemTapped()  {
        guard !isTransitioning,
              activeViewController != centerViewController else { return }

        activePosition = .center

        let _ = popToRootViewController(animated: shouldAnimateTransitions)
    }

    @objc private func rightItemTapped() {
        guard !isTransitioning,
              let rightVC = rightViewController,
              activeViewController != rightVC else { return }

        let previousPosition = activePosition
        activePosition = .right

        switch previousPosition {
        case .left:
            navigateAcross(to: rightVC)
        case .right:
            let _ = popToViewController(rightVC, animated: shouldAnimateTransitions)
        case .center:
            pushViewController(rightVC, animated: shouldAnimateTransitions)
        }
    }
}
