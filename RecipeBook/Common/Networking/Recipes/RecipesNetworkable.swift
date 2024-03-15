//
//  RecipesNetworkable.swift
//  RecipeBook
//
//  Created by Ilya Slipak on 26.10.2023.
//

import Foundation

protocol RecipesNetworkable {
    func getRecipes() async -> Result<[Recipe], ApiError>
}
