//
//  StaticNavigationBar.swift
//  StaticNavigationController
//
//  Created by Seth Folley on 12/25/17.
//  Copyright © 2017 Seth Folley. All rights reserved.
//

import UIKit

class StaticNavigationBar: UINavigationBar {
    lazy var slider: UIView = {
        let view = UIView()
        view.frame.size.width = 44
        view.frame.size.height = 1
        view.frame.origin.x = (self.frame.width - view.frame.width) / 2.0
        view.frame.origin.y = self.frame.height - view.frame.height
        view.layer.cornerRadius = 1
        view.layer.masksToBounds = true
        view.backgroundColor = .green
        return view
    }()

    // MARK: Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)

        tintColor = .yellow
        barTintColor = .purple
        isTranslucent = false
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: UI
    func addSubviews() {
        self.addSubview(slider)
    }

    // MARK: Position Selectors
    // TODO: Move slider center
    func centerItemSelected() { print(#function)
        move(to: .center)
    }
    // TODO: Move slider left
    func leftItemSelected(){ print(#function)
        move(to: .left)
    }

    // TODO: Move slider right
    func rightItemSelected(){ print(#function)
        move(to: .right)
    }

    private func move(to: StaticNavigationPosition, animated: Bool = true) {
        var finalOriginX: CGFloat = 0

        switch to {
        case .left:
            finalOriginX = 0
            break
        case .right:
            finalOriginX = frame.width - (slider.frame.width)
            break
        case .center:
            finalOriginX = (frame.width - slider.frame.width) * 0.5
            break
        }

        UIView.animate(withDuration: animated ? 0.2 : 0.0) {
            self.slider.frame.origin.x = finalOriginX
            print("Navigation bar position view frame: ", self.slider.frame)
        }
    }
}
