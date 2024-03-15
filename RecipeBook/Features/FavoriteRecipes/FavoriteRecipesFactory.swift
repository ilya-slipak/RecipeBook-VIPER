//
//  FavoriteRecipesFactory.swift
//  RecipeBook
//
//  Created by Ilya Slipak on 28.10.2023.
//

import Foundation

struct FavoriteRecipesFactory {
    static func make() -> FavoriteRecipesViewController {
        let viewController = FavoriteRecipesViewController()
        let presenter = FavoriteRecipesPresenter()
        let interactor = FavoriteRecipesInteractor()
        let router = FavoriteRecipesRouter(viewController: viewController)

        viewController.presenter = presenter
        presenter.router = router
        presenter.view = viewController
        presenter.interactor = interactor

        return viewController
    }
}
