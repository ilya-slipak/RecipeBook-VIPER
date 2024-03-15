//
//  UIAlertViewController+Make.swift
//  RecipeBook
//
//  Created by Ilya Slipak on 28.10.2023.
//

import UIKit

// MARK: - UIAlertController + Make

extension UIAlertController {
    static func makeDefault(with title: String, onTapOk: (() -> Void)?) -> UIAlertController {
        let alertController = UIAlertController(
            title: title,
            message: nil,
            preferredStyle: .alert
        )

        let okAlertAction = UIAlertAction(
            title: "OK",
            style: .default,
            handler: { _ in
                onTapOk?()
            }
        )
        alertController.addAction(okAlertAction)

        return alertController
    }
}
