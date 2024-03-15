//
//  RecipeDetailInteractor.swift
//  RecipeBook
//
//  Created by Ilya Slipak on 28.10.2023.
//

import Foundation

// MARK: - RecipeListInteractorLayer

protocol RecipeDetailInteractorLayer: AnyObject, RecipeFavoriteManageable {}

// MARK: - RecipeListInteractor

final class RecipeDetailInteractor {}

// MARK: - RecipeDetailInteractor + RecipeDetailInteractorLayer

extension RecipeDetailInteractor: RecipeDetailInteractorLayer {}
