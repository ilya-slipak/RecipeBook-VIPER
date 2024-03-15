//
//  UIImageView+Make.swift
//  RecipeBook
//
//  Created by Ilya Slipak on 28.10.2023.
//

import UIKit

// MARK: - UIImageView + Make

extension UIImageView {
    static func makeCropped(cornerRadius: CGFloat = .zero) -> UIImageView {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = cornerRadius
        imageView.contentMode = .scaleAspectFill
        return imageView
    }
}
