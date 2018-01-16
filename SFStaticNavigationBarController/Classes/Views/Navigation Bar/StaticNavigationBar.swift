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
    /// The length of the slider. Default value is 44.0
    public var sliderLength: CGFloat = 44.0

    /// The thickness of the slider. Default value is 1.0
    public var sliderWidth: CGFloat = 1.0

    /// Defines if the slider is hidden. Default is false
    public var isSliderHidden: Bool = false

    /// The color of the slider. Default is Dark Gray
    public var sliderColor: UIColor = .darkGray

    /// The corner radius for the slider. Default is 1.0
    public var sliderCornerRadius: CGFloat = 1.0

    /// The slider will come this close to the screens edge. Can be negative. Default is 0.0
    public var sliderMarginToEdge: CGFloat = 0.0

    var currentSliderPosition = StaticNavigationPosition.center

    lazy var slider: UIView = {
        let view = UIView()
        view.frame.size.width = self.sliderLength
        view.frame.size.height = self.sliderWidth
        view.frame.origin.x = (self.frame.width - view.frame.width) / 2.0
        view.frame.origin.y = self.frame.height - view.frame.height
        view.layer.cornerRadius = self.sliderCornerRadius
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
    }
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: UI
    func addSubviews() {
        self.addSubview(slider)
    }
}
