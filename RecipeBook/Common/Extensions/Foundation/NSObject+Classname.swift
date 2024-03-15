//
//  NSobject+Classname.swift
//  RecipeBook
//
//  Created by Ilya Slipak on 26.10.2023.
//

import Foundation

// MARK: - NSObject + ClassName

extension NSObject {
    static var className: String {
        String(describing: Self.self)
    }
}
