//
//  UserDefaultWrapper.swift
//  RecipeBook
//
//  Created by Ilya Slipak on 26.10.2023.
//
// Inspired by: https://www.avanderlee.com/swift/property-wrappers/

import Foundation

// MARK: - AnyOptional

// Allows to match for optionals with generics that are defined as non-optional.
fileprivate protocol AnyOptional {
    // Returns `true` if `nil`, otherwise `false`.
    var isNil: Bool { get }
}

// MARK: - Optional + AnyOptional

extension Optional: AnyOptional {
    public var isNil: Bool { self == nil }
}

// MARK: - UserDefaultPrimitiveWrapper

// Wrapper that works with primitive types: String, Int, Double, Bool etc.
@propertyWrapper
struct UserDefaultPrimitiveWrapper<Value> {

    let key: String

    let defaultValue: Value
    
    private let container: UserDefaults = .standard

    var wrappedValue: Value {
        get {
            return container.object(forKey: key) as? Value ?? defaultValue
        }
        set {
            // Check whether we're dealing with an optional and remove the object if the new value is nil.
            if let optional = newValue as? AnyOptional, optional.isNil {
                container.removeObject(forKey: key)
            } else {
                container.set(newValue, forKey: key)
            }
        }
    }
}

// MARK: - UserDefaultCustomTypeWrapper

// Wrapper that works with custom types that conform Codable
@propertyWrapper
struct UserDefaultCustomTypeWrapper<Value: Codable> {
    let key: String

    let defaultValue: Value

    private let container: UserDefaults = .standard

    private let encoder: JSONEncoder = .init()

    private let decoder: JSONDecoder = .init()

    var wrappedValue: Value {
        get {
            guard 
                let data = container.data(forKey: key),
                let decodedModel = try? decoder.decode(Value.self, from: data)
            else {
                return defaultValue
            }
            return decodedModel
        }
        set {
            // Check whether we're dealing with an optional and remove the object if the new value is nil.
            if let optional = newValue as? AnyOptional, optional.isNil {
                container.removeObject(forKey: key)
            } else {
                if let encodedData = try? JSONEncoder().encode(newValue) {
                    container.set(encodedData, forKey: key)
                } else {
                    container.removeObject(forKey: key)
                }
            }
        }
    }
}
