//
//  SearchRecipeListFactory.swift
//  RecipeBook
//
//  Created by Ilya Slipak on 28.10.2023.
//

import Foundation

struct SearchRecipeListFactory {
    static func make() -> SearchRecipeListViewController {
        let viewController = SearchRecipeListViewController()
        let presenter = SearchRecipeListPresenter()
        let interactor = SearchRecipeListInteractor()
        let router = SearchRecipeListRouter(viewController: viewController)
        
        viewController.presenter = presenter
        presenter.router = router
        presenter.view = viewController
        presenter.interactor = interactor
        
        return viewController
    }
}
