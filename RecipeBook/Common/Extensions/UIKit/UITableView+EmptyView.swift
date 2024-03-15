//
//  UITableView+EmptyView.swift
//  RecipeBook
//
//  Created by Ilya Slipak on 28.10.2023.
//

import UIKit

// MARK: - UITableView + EmptyView

extension UITableView {
    enum ViewType {
        case recipe

        var title: String {
            switch self {
            case .recipe:
                return "No recipes"
            }
        }
    }

    func addEmptyView(_ type: UITableView.ViewType) {
        switch type {
        case .recipe:
            backgroundView = RecipeEmptyView(with: type.title)
        }
    }

    func removeEmptyView() {
        backgroundView = nil
    }
}
