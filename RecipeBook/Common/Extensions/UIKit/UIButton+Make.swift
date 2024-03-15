//
//  UIButton+Make.swift
//  RecipeBook
//
//  Created by Ilya Slipak on 28.10.2023.
//

import UIKit

// MARK: - UIButton + Make

extension UIButton {
    static func make(icon: IconType, tintColor: UIColor = .white) -> UIButton {
        .make(image: .make(icon: icon), tintColor: tintColor)
    }

    static func make(image: UIImage?, tintColor: UIColor = .white) -> UIButton {
        let button = UIButton()
        button.tintColor = tintColor
        button.setImage(image, for: .normal)
        return button
    }
}
