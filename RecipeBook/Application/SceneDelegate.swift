//
//  SceneDelegate.swift
//  RecipeBook
//
//  Created by Ilya Slipak on 21.10.2023.
//

import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let windowScene = (scene as? UIWindowScene) else { 
            return
        }

        UINavigationBar.appearance().tintColor = .white
        UINavigationBar.appearance().barStyle = .black
        let recipeListViewController = RecipeListFactory.make()
        let navigationController = UINavigationController(rootViewController: recipeListViewController)
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}
