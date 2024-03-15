//
//  RecipeListPresenter.swift
//  RecipeBook
//
//  Created by Ilya Slipak on 25.10.2023.
//

import Foundation

// MARK: - RecipeListPresenterLayer

protocol RecipeListPresenterLayer: AnyObject {
    var navigationTitle: String { get }
    
    func handleDidTapSearch()
    
    func handleDidTapFavorite()
    
    func getRecipes()
    
    func recipesCount() -> Int
    
    func recipe(at indexPath: IndexPath) -> Recipe
    
    func handleDidSelectRow(at indexPath: IndexPath)
    
    func handleDidTapFavorite(at indexPath: IndexPath)
}

// MARK: - RecipeListPresenter

final class RecipeListPresenter {
    // MARK: - Internal Properties
    
    weak var view: RecipeListViewLayer!
    
    var router: RecipeListRouterLayer!
    
    var interactor: RecipeListInteractorLayer!
    
    private(set) var navigationTitle: String = "Recipes"
    
    // MARK: - Private Properties
    
    private var recipes: [Recipe] = []
}

// MARK: - RecipeListPresenter + RecipeListPresenterLayer

extension RecipeListPresenter: RecipeListPresenterLayer {
    func handleDidTapSearch() {
        router.showSearch()
    }
    
    func handleDidTapFavorite() {
        router.showFavorites()
    }
    
    func getRecipes() {
        Task { @MainActor in
            let result = await interactor.getRecipes()
            
            switch result {
            case .success(let recipes):
                self.recipes = recipes.sorted(by: <)
                self.view.reloadData()
            case .failure(let error):
                self.router.showSystemAlert(with: error.localizedDescription, onTapOk: nil)
            }
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
                let index = recipes.firstIndex(where: { $0.identifier == recipe.identifier })
            else {
                return
            }
            
            recipes[index] = updatedRecipe
            view.reloadData()
        }
    }
}
