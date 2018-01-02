//
//  Array.swift
//  IntuitiveNavigationController
//
//  Created by Seth Folley on 12/27/17.
//  Copyright © 2017 Seth Folley. All rights reserved.
//

import Foundation
import UIKit

extension Array where Element: UIViewController {

    @discardableResult
    mutating func removeAll(after index: Int) -> [UIViewController]? {
        guard index > self.count - 1 else { return nil }

        var removedViewControllers: [UIViewController] = []

        let timesToRemoveLast = self.count - index - 1

        for _ in 1...timesToRemoveLast {
            let viewController = self.removeLast() as UIViewController
            removedViewControllers.append(viewController)
        }

        return removedViewControllers
    }
}
