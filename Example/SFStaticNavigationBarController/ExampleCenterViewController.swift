//
//  ExampleCenterViewController.swift
//  IntuitiveNavigationController_Example
//
//  Created by Seth Folley on 12/30/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit

class ExampleCenterViewController: UIViewController {

    lazy var vcLabel: UILabel = {
        let label = UILabel()
        label.text = self.title
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Center VC"
        view.addSubview(vcLabel)

        setupAutoLayout()
    }

    func setupAutoLayout() {
        vcLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        vcLabel.heightAnchor.constraint(equalToConstant: 60).isActive = true
        vcLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        vcLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor,
                                         constant: -60).isActive = true
    }
}
