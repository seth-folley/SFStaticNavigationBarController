//
//  StaticNavigationBar+SliderAnimation.swift
//  SFStaticNavigationBarController
//
//  Created by Seth Folley on 1/3/18.
//

import Foundation
import UIKit

extension StaticNavigationBar {

    // MARK: Center X for slider positions
    private var leftCenterX: CGFloat {
        let leftMargin = layoutMargins.left
        var buttonWidth: CGFloat = 0.0
        if let leftButton = topItem?.leftBarButtonItem, let leftView = leftButton.value(forKey: "view") as? UIView {
            buttonWidth = leftView.frame.width
        }

        return leftMargin + (0.5 * buttonWidth)
    }
    private var rightCenterX: CGFloat {
        let rightMargin = layoutMargins.right
        var buttonWidth: CGFloat = 0.0
        if let rightButton = topItem?.rightBarButtonItem, let rightView = rightButton.value(forKey: "view") as? UIView {
            buttonWidth = rightView.frame.width
        }

        return frame.width - rightMargin - (0.5 * buttonWidth)
    }

    // MARK: Position Selectors
    func centerItemSelected() { print(#function)
        moveSlider(to: .center)
    }
    func leftItemSelected(){ print(#function)
        moveSlider(to: .left)
    }
    func rightItemSelected(){ print(#function)
        moveSlider(to: .right)
    }

    private func moveSlider(to position: StaticNavigationPosition, animated: Bool = true) {
        var centerX: CGFloat = 0

        switch position {
        case .left:
            centerX = leftCenterX
            break
        case .right:
            centerX = rightCenterX
            break
        case .center:
            centerX = frame.width * 0.5
            break
        }

        let finalOriginX = centerX - (sliderLength * 0.5)
        UIView.animate(withDuration: animated ? 0.2 : 0.0) {
            self.slider.frame.origin.x = finalOriginX
            print("Navigation bar position view frame: ", self.slider.frame)
        }
    }
}
