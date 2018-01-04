//
//  ExampleRightViewController.swift
//  IntuitiveNavigationController_Example
//
//  Created by Seth Folley on 12/30/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit

class ExampleRightViewController: UIViewController {

    lazy var vcLabel: UILabel = {
        let label = UILabel()
        label.text = self.title
        label.translatesAutoresizingMaskIntoConstraints = false
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

        title = "Right VC"
        view.addSubview(vcLabel)
        view.addSubview(anotherVCButton)

        setupAutoLayout()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        // set navigation bar attributes
        navigationController?.navigationBar.barTintColor = .yellow
        navigationController?.navigationBar.tintColor = .purple
        staticNavigationController?.navBar?.sliderColor = .purple

        // adjust bar items
        staticNavigationController?.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .camera, target: nil, action: nil)
        staticNavigationController?.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .fastForward, target: nil, action: nil)
        staticNavigationController?.centerItem = UIButton(type: .infoDark) // can be any UIView
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
