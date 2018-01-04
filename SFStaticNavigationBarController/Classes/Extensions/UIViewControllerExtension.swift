//
//  UIViewControllerExtension.swift
//  SFStaticNavigationBarController
//
//  Created by Seth Folley on 1/3/18.
//

import Foundation
import UIKit

public extension UIViewController {
    var staticNavigationController: StaticNavigationController? {
        return navigationController as? StaticNavigationController
    }
}
