//
//  UILabel+Make.swift
//  RecipeBook
//
//  Created by Ilya Slipak on 28.10.2023.
//

import UIKit

// MARK: - UILabel + Make

extension UILabel {
    enum Style {
        case bold(textAlignment: NSTextAlignment)

        case body(textAlignment: NSTextAlignment)

        case regularCentered

        var font: UIFont {
            switch self {
            case .bold:
                return .boldSystemFont(ofSize: 22)
            case .body:
                return .systemFont(ofSize: 16)
            case .regularCentered:
                return .systemFont(ofSize: 15)
            }
        }

        var numberOfLines: Int {
            switch self {
            case .bold, .regularCentered, .body:
                return 0
            }
        }

        var textColor: UIColor {
            switch self {
            case .bold, .regularCentered, .body:
                return .white
            }
        }

        var textAlignment: NSTextAlignment {
            switch self {
            case .bold(let textAlignment):
                return textAlignment
            case .regularCentered:
                return .center
            case .body(let textAlignment):
                return textAlignment
            }
        }
    }

    static func make(style: Style) -> UILabel {
        .make(
            font: style.font,
            numberOfLines: style.numberOfLines,
            textColor: style.textColor,
            textAlignment: style.textAlignment
        )
    }

    static func make(
        font: UIFont,
        numberOfLines: Int,
        textColor: UIColor,
        textAlignment: NSTextAlignment
    ) -> UILabel {
        let label = UILabel()
        label.font = font
        label.textColor = textColor
        label.textAlignment = textAlignment
        label.numberOfLines = numberOfLines
        return label
    }
}
