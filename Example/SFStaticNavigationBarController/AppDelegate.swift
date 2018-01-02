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
        centerVC.view.backgroundColor = .gray
        let leftVC = ExampleLeftViewController()
        leftVC.view.backgroundColor = .red
        let rightVC = ExampleRightViewController()
        rightVC.view.backgroundColor = .brown

        let leftItem = UIBarButtonItem(barButtonSystemItem: .camera, target: nil, action: nil)
        let rightItem = UIBarButtonItem(barButtonSystemItem: .compose, target: nil, action: nil)
        let centerItem = UIButton(type: .contactAdd)

        let rootVC = StaticNavigationController(centerViewController: centerVC)
        rootVC.leftViewController = leftVC
        rootVC.rightViewController = rightVC
        rootVC.leftBarButtonItem = leftItem
        rootVC.rightBarButtonItem = rightItem
        rootVC.centerButton = centerItem

        window?.rootViewController = rootVC
        window?.makeKeyAndVisible()
        return true
    }
}

