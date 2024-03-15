//
//  FavoriteRecipesInteractor.swift
//  RecipeBook
//
//  Created by Ilya Slipak on 28.10.2023.
//

import Foundation

// MARK: - RecipeListInteractorLayer

protocol FavoriteRecipesInteractorLayer: AnyObject, RecipeFavoriteManageable {
    func getFavoriteRecipes() async -> [Recipe]
}

// MARK: - RecipeListInteractor

final class FavoriteRecipesInteractor {}

// MARK: - FavoriteRecipesInteractor + FavoriteRecipesInteractorLayer

extension FavoriteRecipesInteractor: FavoriteRecipesInteractorLayer {
    func getFavoriteRecipes() async -> [Recipe] {
        UserDefaults.recipes.filter(\.isFavorite)
    }
}
