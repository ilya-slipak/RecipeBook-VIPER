//
//  SearchRecipeListRouter.swift
//  RecipeBook
//
//  Created by Ilya Slipak on 28.10.2023.
//

import UIKit

// MARK: - SearchRecipeListRouterLayer

protocol SearchRecipeListRouterLayer: AnyObject {
    func showDetail(with recipe: Recipe)
}

// MARK: - SearchRecipeListRouter

final class SearchRecipeListRouter {
    // MARK: - Internal Properties
    
    weak var viewController: SearchRecipeListViewController!
    
    // MARK: - Init
    
    init(viewController: SearchRecipeListViewController) {
        self.viewController = viewController
    }
}

// MARK: - SearchRecipeListRouter + SearchRecipeListRouterLayer

extension SearchRecipeListRouter: SearchRecipeListRouterLayer {
    func showDetail(with recipe: Recipe) {
        let recipesDetailController = RecipeDetailFactory.make(with: recipe)
        viewController.navigationController?.pushViewController(recipesDetailController, animated: true)
    }
}
