//
//  AppDelegate.swift
//  IntuitiveNavigationController
//
//  Created by crystalSETH on 12/30/2017.
//  Copyright (c) 2017 crystalSETH. All rights reserved.
//

import UIKit
import SFStaticNavigationBarController

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow? = UIWindow(frame: UIScreen.main.bounds)

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        let centerVC = ExampleCenterViewController()
        let leftVC = ExampleLeftViewController()
        let rightVC = ExampleRightViewController()

        let leftItem = UIBarButtonItem(barButtonSystemItem: .trash, target: nil, action: nil)
        let rightItem = UIBarButtonItem(barButtonSystemItem: .compose, target: nil, action: nil)
        let centerItem = UIButton(type: .contactAdd)

        let rootVC = StaticNavigationBarController(centerViewController: centerVC)
        rootVC.leftViewController = leftVC
        rootVC.rightViewController = rightVC
        rootVC.leftBarButtonItem = leftItem
        rootVC.rightBarButtonItem = rightItem
        rootVC.centerItem = centerItem

        window?.rootViewController = rootVC
        window?.makeKeyAndVisible()
        return true
    }
}

