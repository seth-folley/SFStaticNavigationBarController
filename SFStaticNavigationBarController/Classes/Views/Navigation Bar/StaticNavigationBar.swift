//
//  StaticNavigationBar.swift
//  StaticNavigationController
//
//  Created by Seth Folley on 12/25/17.
//  Copyright © 2017 Seth Folley. All rights reserved.
//

import UIKit

public class StaticNavigationBar: UINavigationBar {

    // MARK: Slider vars
    var sliderOrigin: CGPoint {
        var origin = CGPoint.zero
        let sldr = self.slider

        origin.y = self.frame.height - self.sliderSize.height

        switch self.currentSliderPosition{
        case .left:
            origin.x = sldr.leftMargin
        case .center:
            origin.x = (self.frame.width - self.sliderSize.width) / 2.0
        case.right:
            origin.x = self.frame.width - sldr.rightSize.width - sldr.rightMargin
        }

        print("🤪 Slider origin: ", origin)
        return origin
    }

    var sliderSize: CGSize {
        var size = CGSize.zero

        switch self.currentSliderPosition {
        case .left:
            size = self.slider.leftSize
        case .center:
            size = self.slider.centerSize
        case .right:
            size = self.slider.rightSize
        }

        print("🤪 Slider size: ", size)
        return size
    }

    /// The color of the slider. Default is Dark Gray
    public var isSliderHidden = false
    public var sliderColor: UIColor = .darkGray

    /// The corner radius for the slider. Default is 1.0
    var sliderCornerRadius: CGFloat {
        return self.sliderView.frame.height / 2.0
    }

    var currentSliderPosition = StaticNavigationPosition.center

    public var slider = Slider()

    public lazy var sliderView: UIView = {
        let view = UIView(frame: .zero)
        view.frame.size = self.sliderSize
        view.frame.origin = self.sliderOrigin
        view.layer.masksToBounds = true
        view.backgroundColor = self.sliderColor
        return view
    }()

    // MARK: Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)

        tintColor = .black
        barTintColor = .white
        isTranslucent = false

        sliderView.layer.cornerRadius = sliderCornerRadius
    }
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: UI
    func addSubviews() {
        self.addSubview(sliderView)
    }
}
