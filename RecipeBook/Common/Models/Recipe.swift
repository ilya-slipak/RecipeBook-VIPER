//
//  Recipe.swift
//  RecipeBook
//
//  Created by Ilya Slipak on 26.10.2023.
//

import Foundation

// MARK: - Recipe

final class Recipe {
    let identifier: UUID

    let title: String

    let description: String

    let preparationTime: String

    let imageID: String

    let ingredients: [Ingredient]

    var isFavorite: Bool

    init(
        identifier: UUID,
        title: String,
        description: String,
        preparationTime: String,
        imageID: String,
        ingredients: [Ingredient],
        isFavorite: Bool
    ) {
        self.identifier = identifier
        self.title = title
        self.description = description
        self.preparationTime = preparationTime
        self.imageID = imageID
        self.ingredients = ingredients
        self.isFavorite = isFavorite
    }
}

// MARK: - Recipe + Codable

extension Recipe: Codable {
    enum CodingKeys: String, CodingKey {
        case identifier
        case title
        case description
        case preparationTime = "preparation_time"
        case imageID = "image_id"
        case ingredients
        case isFavorite
    }
}

// MARK: - Equatable

extension Recipe: Equatable {
    static func == (lhs: Recipe, rhs: Recipe) -> Bool {
        lhs.identifier == rhs.identifier
    }
}

// MARK: - Comparable

extension Recipe: Comparable {
    static func < (lhs: Recipe, rhs: Recipe) -> Bool {
        lhs.title < rhs.title
    }
}

// MARK: - Dummy Recipe

extension Recipe {
    static func makeDummy() -> Recipe
    {
        .init(
            identifier: UUID(),
            title: "",
            description: "",
            preparationTime: "",
            imageID: "",
            ingredients: [],
            isFavorite: false
        )
    }
}

// MARK: - Recipe.Ingredient

extension Recipe {
    struct Ingredient: Codable {

        let title: String

        let amount: String?
    }
}
