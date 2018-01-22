//
//  ExampleLeftViewController.swift
//  IntuitiveNavigationController_Example
//
//  Created by Seth Folley on 12/30/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit
import Cartography
import ChameleonFramework

class ExampleLeftViewController: UIViewController {

    lazy var vcLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .flatMintDark
        label.layer.cornerRadius = 5
        label.layer.masksToBounds = true
        label.text = "Left View Controller"
        label.textAlignment = .center
        label.textColor = .flatWhite
        label.adjustsFontSizeToFitWidth = true
        return label
    }()

    lazy var pushVCButton: UIButton = {
        let button = UIButton()
        button.setTitle("Push VC", for: .normal)
        button.layer.borderColor = UIColor.darkGray.cgColor
        button.layer.borderWidth = 2
        button.layer.cornerRadius = 5
        button.layer.masksToBounds = true
        button.backgroundColor = .flatMagenta
        button.addTarget(self, action: #selector(pushButtonTapped), for: .touchUpInside)
        return button
    }()

    lazy var presentVCButton: UIButton = {
        let button = UIButton()
        button.setTitle("Present VC", for: .normal)
        button.layer.borderColor = UIColor.darkGray.cgColor
        button.layer.borderWidth = 2
        button.layer.cornerRadius = 5
        button.layer.masksToBounds = true
        button.backgroundColor = .flatCoffee
        button.addTarget(self, action: #selector(presentButtonTapped), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .flatWhite
        view.addSubview(vcLabel)
        view.addSubview(pushVCButton)
        view.addSubview(presentVCButton)

        setupAutoLayout()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        staticNavigationBarController?.shouldAnimateAcrossCenter = true

        // set navigation bar attributes
    }

    func setupAutoLayout() {
        constrain(vcLabel) { view in
            view.leading  == view.superview!.leading + 20
            view.trailing == view.superview!.trailing - 20
            view.height   == 60
            view.top      == view.superview!.top + 50
        }

        constrain(pushVCButton) { view in
            view.width   == 100
            view.height  == 50
            view.centerX == view.superview!.centerX * 0.5
            view.bottom  == view.superview!.bottom - 50
        }

        constrain(presentVCButton) { view in
            view.width   == 100
            view.height  == 50
            view.centerX == view.superview!.centerX * 1.5
            view.bottom  == view.superview!.bottom - 50
        }
    }

    @objc private func pushButtonTapped() {
        navigationController?.pushViewController(ExampleAdditionalViewController(), animated: true)
    }

    @objc private func presentButtonTapped() {
        present(ExampleAdditionalViewController(), animated: true)
    }
}
