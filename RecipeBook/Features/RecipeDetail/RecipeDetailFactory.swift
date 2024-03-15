//
//  RecipeDetailFactory.swift
//  RecipeBook
//
//  Created by Ilya Slipak on 28.10.2023.
//

import Foundation

struct RecipeDetailFactory {
    static func make(with recipe: Recipe) -> RecipeDetailViewController {
        let viewController = RecipeDetailViewController()
        let presenter = RecipeDetailPresenter(with: recipe)
        let interactor = RecipeDetailInteractor()
        let router = RecipeDetailRouter(viewController: viewController)
        
        viewController.presenter = presenter
        presenter.router = router
        presenter.view = viewController
        presenter.interactor = interactor
        
        return viewController
    }
}
