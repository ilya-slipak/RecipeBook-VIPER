//
//  APIError.swift
//  RecipeBook
//
//  Created by Ilya Slipak on 26.10.2023.
//

import Foundation

struct ApiError: LocalizedError {
    let message: String

    init(message: String) {
        self.message = message
    }
}
