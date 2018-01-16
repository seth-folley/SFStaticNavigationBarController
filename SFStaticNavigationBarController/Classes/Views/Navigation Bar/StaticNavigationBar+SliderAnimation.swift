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

    var sliderFinalOriginX: CGFloat {
        var finalOriginX = frame.origin.x

        switch currentSliderPosition {
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

        return finalOriginX
    }

    func moveSlider(to position: StaticNavigationPosition, animated: Bool = true) {
        currentSliderPosition = position

        UIView.animate(withDuration: animated ? 0.2 : 0.0) {
            self.slider.isHidden = self.isSliderHidden
            self.slider.frame.size.width = self.sliderLength
            self.slider.frame.size.height = self.sliderWidth
            self.slider.layer.cornerRadius = self.sliderCornerRadius
            self.slider.backgroundColor = self.sliderColor
            self.slider.frame.origin.x = self.sliderFinalOriginX
        }
    }

    public func updateSliderDetails(animated: Bool, duration: Double = 0.3) {
        UIView.animate(withDuration: animated ? duration : 0.0) {
            self.slider.isHidden = self.isSliderHidden
            self.slider.frame.size.width = self.sliderLength
            self.slider.frame.size.height = self.sliderWidth
            self.slider.layer.cornerRadius = self.sliderCornerRadius
            self.slider.backgroundColor = self.sliderColor
        }
    }
}
