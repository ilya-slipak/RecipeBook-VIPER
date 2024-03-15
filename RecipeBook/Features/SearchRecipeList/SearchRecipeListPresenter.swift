//
//  SearchRecipeListPresenter.swift
//  RecipeBook
//
//  Created by Ilya Slipak on 28.10.2023.
//

import Foundation

// MARK: - SearchRecipeListPresenterLayer

protocol SearchRecipeListPresenterLayer: AnyObject {
    var navigationTitle: String { get }
    
    var searchTextFieldPlaceholder: String { get }
    
    func getRecipes()
    
    func getRecipesConsideringSearch(_ searchQuery: String)
    
    func recipesCount() -> Int
    
    func recipe(at indexPath: IndexPath) -> Recipe
    
    func handleDidSelectRow(at indexPath: IndexPath)
    
    func handleDidTapFavorite(at indexPath: IndexPath)
}

// MARK: - SearchRecipeListPresenter

final class SearchRecipeListPresenter {
    // MARK: - Internal Properties
    
    weak var view: SearchRecipeListViewLayer!
    
    var router: SearchRecipeListRouterLayer!
    
    var interactor: SearchRecipeListInteractorLayer!
    
    private(set) var navigationTitle: String = "Search"
    
    private(set) var searchTextFieldPlaceholder: String = "Search for a recipe"
    
    // MARK: - Private Properties
    
    private var searchQuery: String?
    
    private var recipes: [Recipe] = []
    
    // MARK: - Private API
    
    private func getRecipes(with searchInput: String?) {
        Task { @MainActor in
            let requestedRecipes = await interactor.getRecipes(with: searchInput)
            recipes = requestedRecipes.sorted(by: <)
            view.reloadData()
        }
    }
}

// MARK: - SearchRecipeListPresenter + SearchRecipeListPresenterLayer

extension SearchRecipeListPresenter: SearchRecipeListPresenterLayer {
    func getRecipes() {
        getRecipes(with: searchQuery)
    }
    
    func getRecipesConsideringSearch(_ searchQuery: String) {
        self.searchQuery = searchQuery
        getRecipes(with: searchQuery)
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
                let index = recipes.firstIndex(where: { $0.identifier == recipe.identifier })
            else {
                return
            }
            
            recipes[index] = updatedRecipe
            view.reloadData()
        }
    }
}
