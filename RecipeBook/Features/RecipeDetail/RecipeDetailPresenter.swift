//
//  RecipeDetailPresenter.swift
//  RecipeBook
//
//  Created by Ilya Slipak on 28.10.2023.
//

import Foundation

// MARK: - RecipeDetailPresenterLayer

protocol RecipeDetailPresenterLayer: AnyObject {
    var navigationTitle: String { get }
    
    var recipe: Recipe { get }
    
    func handleDidTapFavorite()
}

// MARK: - RecipeDetailPresenter

final class RecipeDetailPresenter {
    // MARK: - Internal Properties
    
    weak var view: RecipeDetailViewLayer!
    
    var router: RecipeDetailRouterLayer!
    
    var interactor: RecipeDetailInteractorLayer!
    
    private(set) var navigationTitle: String = "Detail"
    
    private(set) var recipe: Recipe
    
    init(with recipe: Recipe) {
        self.recipe = recipe
    }
}

// MARK: - RecipeDetailPresenter + RecipeDetailPresenterLayer

extension RecipeDetailPresenter: RecipeDetailPresenterLayer {
    func handleDidTapFavorite() {
        Task { @MainActor in
            guard let updatedRecipe = await interactor.updateFavoriteStatus(for: recipe.identifier) else { 
                return
            }
            
            recipe = updatedRecipe
            view.reloadData()
        }
    }
}
