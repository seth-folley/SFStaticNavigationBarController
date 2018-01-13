//
//  StaticNavigationBar+SliderAnimation.swift
//  SFStaticNavigationBarController
//
//  Created by Seth Folley on 1/3/18.
//

import Foundation
import UIKit

extension StaticNavigationBar {

    // MARK: Position Selectors
    func centerItemSelected() {
        moveSlider(to: .center)
    }
    func leftItemSelected(){
        moveSlider(to: .left)
    }
    func rightItemSelected(){
        moveSlider(to: .right)
    }

    func moveSlider(to position: StaticNavigationPosition, animated: Bool = true) {
        var finalOriginX = frame.origin.x

        switch position {
        case .left:
            finalOriginX += sliderMarginToEdge
            break
        case .right:
            finalOriginX = frame.width - sliderLength - sliderMarginToEdge
            break
        case .center:
            finalOriginX = (frame.width - sliderLength) * 0.5
            break
        }

        UIView.animate(withDuration: animated ? 0.2 : 0.0) {
            self.slider.frame.origin.x = finalOriginX
        }
    }
}
