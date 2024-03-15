//
//  FavoriteRecipesRouter.swift
//  RecipeBook
//
//  Created by Ilya Slipak on 28.10.2023.
//

import UIKit

// MARK: - FavoriteRecipesRouterLayer

protocol FavoriteRecipesRouterLayer: AnyObject {
    func showDetail(with recipe: Recipe)
}

// MARK: - FavoriteRecipesRouter

final class FavoriteRecipesRouter {
    // MARK: - Internal Properties
    
    weak var viewController: FavoriteRecipesViewController!
    
    // MARK: - Init
    
    init(viewController: FavoriteRecipesViewController) {
        self.viewController = viewController
    }
}

// MARK: - FavoriteRecipesRouter + FavoriteRecipesRouterLayer

extension FavoriteRecipesRouter: FavoriteRecipesRouterLayer {
    func showDetail(with recipe: Recipe) {
        let recipesDetailController = RecipeDetailFactory.make(with: recipe)
        viewController.navigationController?.pushViewController(recipesDetailController, animated: true)
    }
}
