//
//  ExampleCenterViewController.swift
//  IntuitiveNavigationController_Example
//
//  Created by Seth Folley on 12/30/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit
import Cartography
import ChameleonFramework

class ExampleCenterViewController: UIViewController {

    lazy var vcLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .flatPlum
        label.layer.cornerRadius = 5
        label.layer.masksToBounds = true
        label.text = "Center View Controller"
        label.textAlignment = .center
        label.textColor = .flatWhite
        label.adjustsFontSizeToFitWidth = true
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .flatWhite
        view.addSubview(vcLabel)
        setupAutoLayout()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        // Set navigation bar attributes
    }

    func setupAutoLayout() {
        constrain(vcLabel) { view in
            view.leading  == view.superview!.leading + 20
            view.trailing == view.superview!.trailing - 20
            view.height   == 60
            view.top      == view.superview!.top + 50
        }
    }
}
