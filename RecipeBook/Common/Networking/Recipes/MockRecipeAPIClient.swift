//
//  MockRecipeAPIClient.swift
//  RecipeBook
//
//  Created by Ilya Slipak on 26.10.2023.
//

import Foundation

// MARK: - MockRecipeAPIClient

final class MockRecipeAPIClient {
    // MARK: - Private Properties

    private let bundle = Bundle.main

    private let decoder = JSONDecoder()
}

// MARK: - MockRecipeAPIClient + RecipesNetworkable

extension MockRecipeAPIClient: RecipesNetworkable {
    func getRecipes() async -> Result<[Recipe], ApiError> {
        guard let path = bundle.url(forResource: "recipes", withExtension: ".json") else {
            return .failure(ApiError(message: "Invalid json path"))
        }
        do {
            let data = try Data(contentsOf: path)
            let response = try decoder.decode(EntitiesResponse<Recipe>.self, from: data)
            return .success(response.entities)
        } catch {
            return .failure(ApiError(message: error.localizedDescription))
        }
    }
}
