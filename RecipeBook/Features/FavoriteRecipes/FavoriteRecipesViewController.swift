//
//  FavoriteRecipesViewController.swift
//  RecipeBook
//
//  Created by Ilya Slipak on 28.10.2023.
//

import UIKit

// MARK: - FavoriteRecipesViewLayer

protocol FavoriteRecipesViewLayer: AnyObject {
    func reloadData()
}

// MARK: - FavoriteRecipesViewController

final class FavoriteRecipesViewController: UIViewController {
    // MARK: - Views
    
    private let recipeListView: RecipeListView = .init()
    
    // MARK: - Internal Properties
    
    var presenter: FavoriteRecipesPresenterLayer!
    
    // MARK: - Lifecycle API
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.getFavoriteRecipes()
    }
    
    // MARK: - Private API
    
    private func setupView() {
        title = presenter.navigationTitle
        view.backgroundColor = .black
        addSubviews()
        configureConstraints()
        setupCallbacks()
        setupActions()
    }
    
    private func setupCallbacks() {
        recipeListView.recipesCountClosure = { [weak self] in
            guard let self = self else {
                return .zero
            }
            
            return self.presenter.recipesCount()
        }
        
        recipeListView.recipeClosure = { [weak self] indexPath in
            guard let self = self else {
                return .makeDummy()
            }
            
            return self.presenter.recipe(at: indexPath)
        }
    }
    
    // MARK: - Actions API
    
    private func setupActions() {
        recipeListView.didTapRecipeClosure = { [weak self] indexPath in
            guard let self = self else {
                return
            }
            
            self.presenter.handleDidSelectRow(at: indexPath)
        }
        
        recipeListView.didTapFavoriteClosure = { [weak self] indexPath in
            guard let self = self else {
                return
            }
            self.presenter.handleDidTapFavorite(at: indexPath)
        }
    }
    
    // MARK: - Layout API
    
    private func addSubviews() {
        view.addSubview(recipeListView)
    }
    
    private func configureConstraints() {
        recipeListView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

// MARK: - FavoriteRecipesViewController + FavoriteRecipesViewLayer

extension FavoriteRecipesViewController: FavoriteRecipesViewLayer {
    func reloadData() {
        recipeListView.reloadData()
    }
}
