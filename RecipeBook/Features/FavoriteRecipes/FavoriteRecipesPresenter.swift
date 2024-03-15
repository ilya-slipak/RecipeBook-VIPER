//
//  FavoriteRecipesPresenter.swift
//  RecipeBook
//
//  Created by Ilya Slipak on 28.10.2023.
//

import Foundation

// MARK: - FavoriteRecipesPresenterLayer

protocol FavoriteRecipesPresenterLayer: AnyObject {
    var navigationTitle: String { get }
    
    func getFavoriteRecipes()
    
    func recipesCount() -> Int
    
    func recipe(at indexPath: IndexPath) -> Recipe
    
    func handleDidSelectRow(at indexPath: IndexPath)
    
    func handleDidTapFavorite(at indexPath: IndexPath)
}

// MARK: - FavoriteRecipesPresenter

final class FavoriteRecipesPresenter {
    // MARK: - Internal Properties
    
    weak var view: FavoriteRecipesViewLayer!
    
    var router: FavoriteRecipesRouterLayer!
    
    var interactor: FavoriteRecipesInteractorLayer!
    
    private(set) var navigationTitle: String = "Favorites"
    
    // MARK: - Private Properties
    
    private var recipes: [Recipe] = []
}

// MARK: - FavoriteRecipesPresenter + FavoriteRecipesPresenterLayer

extension FavoriteRecipesPresenter: FavoriteRecipesPresenterLayer {
    func getFavoriteRecipes() {
        Task { @MainActor in
            let favoriteRecipes = await interactor.getFavoriteRecipes()
            recipes = favoriteRecipes.sorted(by: <)
            view.reloadData()
        }
    }
    
    func recipesCount() -> Int {
        recipes.count
    }
    
    func recipe(at indexPath: IndexPath) -> Recipe {
        recipes[indexPath.row]
    }
    
    func handleDidSelectRow(at indexPath: IndexPath) {
        let recipe = recipes[indexPath.row]
        router.showDetail(with: recipe)
    }
    
    func handleDidTapFavorite(at indexPath: IndexPath) {
        let recipe = recipes[indexPath.row]
        Task { @MainActor in
            guard
                let updatedRecipe = await interactor.updateFavoriteStatus(for: recipe.identifier),
                let index = recipes.firstIndex(where: { $0.identifier == updatedRecipe.identifier }),
                !updatedRecipe.isFavorite
            else { 
                return
            }
            
            recipes.remove(at: index)
            view.reloadData()
        }
    }
}
