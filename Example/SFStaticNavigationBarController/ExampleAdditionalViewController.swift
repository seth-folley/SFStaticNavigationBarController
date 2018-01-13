//
//  ExampleAdditionalViewController.swift
//  IntuitiveNavigationController_Example
//
//  Created by Seth Folley on 12/30/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit
import Cartography
import ChameleonFramework

class ExampleAdditionalViewController: UIViewController {

    lazy var vcLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor(randomFlatColorOf: .dark)
        label.layer.cornerRadius = 5
        label.layer.masksToBounds = true
        label.text = "Additional View Controller"
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

    lazy var dismissVCButton: UIButton = {
        let button = UIButton()
        let title = presentingViewController == nil ? "Pop VC" : "Dismiss VC"
        button.setTitle(title, for: .normal)
        button.layer.borderColor = UIColor.darkGray.cgColor
        button.layer.borderWidth = 2
        button.layer.cornerRadius = 5
        button.layer.masksToBounds = true
        button.backgroundColor = .flatRedDark
        button.addTarget(self, action: #selector(dismissButtonTapped), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .flatWhite
        view.addSubview(vcLabel)
        view.addSubview(pushVCButton)
        view.addSubview(presentVCButton)
        view.addSubview(dismissVCButton)

        setupAutoLayout()
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
            view.bottom  == view.superview!.bottom - 75
        }

        constrain(presentVCButton) { view in
            view.width   == 100
            view.height  == 50
            view.centerX == view.superview!.centerX * 1.5
            view.bottom  == view.superview!.bottom - 75
        }

        constrain(dismissVCButton) { view in
            view.width   == 100
            view.height  == 50
            view.centerX == view.superview!.centerX
            view.bottom  == view.superview!.bottom - 10
        }
    }

    @objc private func pushButtonTapped() {
        navigationController?.pushViewController(ExampleAdditionalViewController(), animated: true)
    }

    @objc private func presentButtonTapped() {
        present(ExampleAdditionalViewController(), animated: true)
    }

    @objc private func dismissButtonTapped() {
        if let vc = presentingViewController {
            vc.dismiss(animated: true, completion: nil)
        } else {
            navigationController?.popViewController(animated: true)
        }
    }
}
