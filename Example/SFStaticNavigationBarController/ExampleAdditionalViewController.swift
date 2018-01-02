//
//  ExampleAdditionalViewController.swift
//  IntuitiveNavigationController_Example
//
//  Created by Seth Folley on 12/30/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit

class ExampleAdditionalViewController: UIViewController {

    lazy var vcLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = self.title
        return label
    }()

    lazy var anotherVCButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("push VC", for: .normal)
        button.layer.borderColor = UIColor.darkGray.cgColor
        button.layer.borderWidth = 2
        button.layer.cornerRadius = 5
        button.layer.masksToBounds = true
        button.backgroundColor = .white
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Additional VC"
        view.addSubview(vcLabel)
        view.addSubview(anotherVCButton)

        setupAutoLayout()
    }

    func setupAutoLayout() {
        vcLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        vcLabel.heightAnchor.constraint(equalToConstant: 60).isActive = true
        vcLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        vcLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor,
                                         constant: -60).isActive = true

        anotherVCButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        anotherVCButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        anotherVCButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        anotherVCButton.centerYAnchor.constraint(equalTo: view.centerYAnchor,
                                                 constant: 60).isActive = true
    }

    @objc private func buttonTapped() {
        navigationController?.pushViewController(ExampleAdditionalViewController(), animated: true)
    }
}
