//
//  String+ContentSize.swift
//  RecipeBook
//
//  Created by Ilya Slipak on 29.10.2023.
//
// Source: https://stackoverflow.com/questions/30450434/figure-out-size-of-uilabel-based-on-string-in-swift/30450559?r=Saves_AllUserSaves#30450559

import UIKit

// MARK: - String + ContentSize

extension String {
    func height(constantWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)

        let boundingBox = self.boundingRect(
            with: constraintRect,
            options: .usesLineFragmentOrigin,
            attributes: [.font: font],
            context: nil
        )

        return ceil(boundingBox.height)
    }

    func width(constantHeight height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)

        let boundingBox = self.boundingRect(
            with: constraintRect,
            options: .usesLineFragmentOrigin,
            attributes: [.font: font],
            context: nil
        )

        return ceil(boundingBox.width)
    }
}
