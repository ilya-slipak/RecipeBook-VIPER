//
//  RecipeDetailRouter.swift
//  RecipeBook
//
//  Created by Ilya Slipak on 28.10.2023.
//

import UIKit

// MARK: - RecipeDetailRouterLayer

protocol RecipeDetailRouterLayer: AnyObject {}

// MARK: - RecipeDetailRouter

final class RecipeDetailRouter {
    // MARK: - Internal Properties
    
    weak var viewController: RecipeDetailViewController!
    
    // MARK: - Init
    
    init(viewController: RecipeDetailViewController) {
        self.viewController = viewController
    }
}

// MARK: - RecipeDetailRouter + RecipeDetailRouterLayer

extension RecipeDetailRouter: RecipeDetailRouterLayer {}
