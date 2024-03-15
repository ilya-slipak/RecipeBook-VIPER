//
//  UIImage+Make.swift
//  RecipeBook
//
//  Created by Ilya Slipak on 28.10.2023.
//

import UIKit

// MARK: - UIImage + Make

extension UIImage {
    static func make(icon: IconType) -> UIImage? {
        switch icon {
        case .heart:
            return UIImage(
                systemName: "heart",
                withConfiguration: UIImage.SymbolConfiguration(scale: .large)
            )
        case .heartFill:
            return UIImage(
                systemName: "heart.fill",
                withConfiguration: UIImage.SymbolConfiguration(scale: .large)
            )
        case .search:
            return UIImage(named: "search_icon")
        }
    }
}
