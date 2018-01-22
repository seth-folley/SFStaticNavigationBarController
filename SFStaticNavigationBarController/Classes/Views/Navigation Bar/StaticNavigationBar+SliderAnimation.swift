//
//  StaticNavigationBar+SliderAnimation.swift
//  SFStaticNavigationBarController
//
//  Created by Seth Folley on 1/3/18.
//

import Foundation
import UIKit

extension StaticNavigationBar {
    func moveSlider(to position: StaticNavigationPosition, animated: Bool = true) {
        currentSliderPosition = position

        UIView.animate(withDuration: animated ? 0.2 : 0.0) {
            self.sliderView.isHidden = self.isSliderHidden
            self.sliderView.frame.origin = self.sliderOrigin
            self.sliderView.frame.size = self.sliderSize
            self.sliderView.layer.cornerRadius = self.sliderCornerRadius
            self.sliderView.backgroundColor = self.sliderColor
        }
    }

    public func updateSliderDetails(animated: Bool, duration: Double = 0.3) {
        UIView.animate(withDuration: animated ? duration : 0.0) {
            self.sliderView.isHidden = self.isSliderHidden
            self.sliderView.frame.origin = self.sliderOrigin
            self.sliderView.frame.size = self.sliderSize
            self.sliderView.layer.cornerRadius = self.sliderCornerRadius
            self.sliderView.backgroundColor = self.sliderColor
        }
    }
}
