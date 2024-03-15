//
//  RecipeFavoriteManageable.swift
//  RecipeBook
//
//  Created by Ilya Slipak on 29.10.2023.
//

import Foundation

protocol RecipeFavoriteManageable: AnyObject { }

extension RecipeFavoriteManageable {
    func updateFavoriteStatus(for recipeID: UUID) async -> Recipe? {
        let localRecipes = UserDefaults.recipes

        guard let recipeIndex = localRecipes.firstIndex(where: { $0.identifier == recipeID }) else {
            return nil
        }

        let recipe = localRecipes[recipeIndex]
        recipe.isFavorite.toggle()
        UserDefaults.recipes[recipeIndex] = recipe
        
        return recipe
    }
}
