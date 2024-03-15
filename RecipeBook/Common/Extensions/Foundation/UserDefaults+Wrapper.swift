//
//  UserDefaults+Wrapper.swift
//  RecipeBook
//
//  Created by Ilya Slipak on 26.10.2023.
// 

import Foundation

// MARK: - UserDefaults + Wrapper

extension UserDefaults {
    enum Keys: String {
        case recipes
    }

    @UserDefaultCustomTypeWrapper(key: Keys.recipes.rawValue, defaultValue: [])
    static var recipes: [Recipe]
}
