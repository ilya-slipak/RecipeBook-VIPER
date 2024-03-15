//
//  SearchRecipeListInteractor.swift
//  RecipeBook
//
//  Created by Ilya Slipak on 28.10.2023.
//

import Foundation

// MARK: - RecipeListInteractorLayer

protocol SearchRecipeListInteractorLayer: AnyObject, RecipeFavoriteManageable {
    func getRecipes(with searchInput: String?) async -> [Recipe]
}

// MARK: - RecipeListInteractor

final class SearchRecipeListInteractor {}

// MARK: - SearchRecipeListInteractor + SearchRecipeListInteractorLayer

extension SearchRecipeListInteractor: SearchRecipeListInteractorLayer {
    func getRecipes(with searchQuery: String?) async -> [Recipe] {
        guard let searchQuery = searchQuery, !searchQuery.isEmpty else {
            return UserDefaults.recipes
        }
        
        return UserDefaults.recipes.filter(searchQuery)
    }
}

// MARK: - Array + Recipe

fileprivate extension Array where Element: Recipe {
    func filter(_ searchQuery: String) -> [Recipe] {
        let searchableString = searchQuery.makeSearchableString()
        // Check if search query without whitespaces is not empty
        guard !searchableString.isEmpty else {
            return []
        }
        // Initialize an empty array to store the filtered results.
        var filteredRecipes: [Recipe] = []
        
        // Iterate through the strings in the input array.
        for recipe in self {
            // Initialize an index to keep track of the characters in the search query.
            var queryIndex = searchableString.startIndex
            
            // Iterate through the characters in the current string.
            for char in recipe.title.makeSearchableString() {
                // Compare the current character in the string with the character in the search query.
                if char == searchableString[queryIndex] {
                    // If they match, move to the next character in the search query.
                    queryIndex = searchableString.index(after: queryIndex)
                    
                    // If we've reached the end of the search query, it means we've found a match.
                    if queryIndex == searchableString.endIndex {
                        // Add the current string to the filtered results.
                        filteredRecipes.append(recipe)
                        // Exit the inner loop and continue with the next string.
                        break
                    }
                }
            }
        }
        
        // Return the filtered results.
        return filteredRecipes
    }
}

// MARK: - String + Searchable

fileprivate extension String {
    func makeSearchableString() -> String {
        components(separatedBy: .whitespaces)
            .joined()
            .lowercased()
    }
}
