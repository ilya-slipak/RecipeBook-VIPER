//
//  RecipeListInteractor.swift
//  RecipeBook
//
//  Created by Ilya Slipak on 25.10.2023.
//

import Foundation

// MARK: - RecipeListInteractorLayer

protocol RecipeListInteractorLayer: AnyObject, RecipeFavoriteManageable {
    func getRecipes() async -> Result<[Recipe], ApiError>
}

// MARK: - RecipeListInteractor

final class RecipeListInteractor {
    // MARK: - Private Properties
    
    private let recipeAPIClient: RecipesNetworkable
    
    // MARK: - Init
    
    init(recipeAPIClient: RecipesNetworkable) {
        self.recipeAPIClient = recipeAPIClient
    }
}

// MARK: - RecipeListInteractor + RecipeListInteractorLayer

extension RecipeListInteractor: RecipeListInteractorLayer {
    func getRecipes() async -> Result<[Recipe], ApiError> {
        let localRecipes = UserDefaults.recipes
        
        guard localRecipes.isEmpty else {
            return .success(localRecipes)
        }
        
        let result = await recipeAPIClient.getRecipes()
        
        switch result {
        case .success(let recipes):
            UserDefaults.recipes = recipes
            return .success(recipes)
        case .failure(let error):
            return .failure(error)
        }
    }
}
