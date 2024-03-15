//
//  Entity.swift
//  RecipeBook
//
//  Created by Ilya Slipak on 26.10.2023.
//

import Foundation

struct EntitiesResponse<T: Decodable>: Decodable {
    let entities: [T]
}
