//
//  RecipeListFactory.swift
//  RecipeBook
//
//  Created by Ilya Slipak on 25.10.2023.
//

import Foundation

struct RecipeListFactory {
    static func make() -> RecipeListViewController {
        let viewController = RecipeListViewController()
        let presenter = RecipeListPresenter()
        let interactor = RecipeListInteractor(recipeAPIClient: MockRecipeAPIClient())
        let router = RecipeListRouter(viewController: viewController)
        
        viewController.presenter = presenter
        presenter.router = router
        presenter.view = viewController
        presenter.interactor = interactor
        
        return viewController
    }
}
