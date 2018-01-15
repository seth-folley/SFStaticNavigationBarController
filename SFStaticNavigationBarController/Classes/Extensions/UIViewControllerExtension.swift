//
//  UIViewControllerExtension.swift
//  SFStaticNavigationBarController
//
//  Created by Seth Folley on 1/3/18.
//

import Foundation
import UIKit

public extension UIViewController {
    var staticNavigationBarController: StaticNavigationBarController? {
        return navigationController as? StaticNavigationBarController
    }
}
