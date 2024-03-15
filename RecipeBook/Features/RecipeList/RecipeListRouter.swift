//
//  RecipeListRouter.swift
//  RecipeBook
//
//  Created by Ilya Slipak on 25.10.2023.
//

import UIKit

// MARK: - RecipeListRouterLayer

protocol RecipeListRouterLayer: AnyObject {
    func showSearch()
    
    func showFavorites()
    
    func showDetail(with recipe: Recipe)
    
    func showSystemAlert(with title: String, onTapOk: (()-> Void)?)
}

// MARK: - RecipeListRouter

final class RecipeListRouter {
    // MARK: - Internal Properties
    
    weak var viewController: RecipeListViewController!
    
    // MARK: - Init
    
    init(viewController: RecipeListViewController) {
        self.viewController = viewController
    }
}

// MARK: - RecipeListRouter + RecipeListRouterLayer

extension RecipeListRouter: RecipeListRouterLayer {
    func showSearch() {
        let searchRecipesController = SearchRecipeListFactory.make()
        viewController.navigationController?.pushViewController(searchRecipesController, animated: true)
    }
    
    func showFavorites() {
        let favoriteRecipesController = FavoriteRecipesFactory.make()
        viewController.navigationController?.pushViewController(favoriteRecipesController, animated: true)
    }
    
    func showDetail(with recipe: Recipe) {
        let recipesDetailController = RecipeDetailFactory.make(with: recipe)
        viewController.navigationController?.pushViewController(recipesDetailController, animated: true)
    }
    
    func showSystemAlert(with title: String, onTapOk: (()-> Void)?) {
        let alertController = UIAlertController.makeDefault(with: title, onTapOk: onTapOk)
        viewController.present(alertController, animated: true)
    }
}
