//
//  RecipeListViewController.swift
//  RecipeBook
//
//  Created by Ilya Slipak on 25.10.2023.
//

import UIKit
import SnapKit

// MARK: - RecipeListViewLayer

protocol RecipeListViewLayer: AnyObject {
    func reloadData()
}

// MARK: - RecipeListViewController

final class RecipeListViewController: UIViewController {
    // MARK: - Views
    
    private let searchButton: UIButton = .make(icon: .search)
    
    private let favoriteButton: UIButton = .make(icon: .heartFill)
    
    private let recipeListView: RecipeListView = .init()
    
    // MARK: - Internal Properties
    
    var presenter: RecipeListPresenterLayer!
    
    // MARK: - Lifecycle API
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.getRecipes()
    }
    
    // MARK: - Private API
    
    private func setupView() {
        title = presenter.navigationTitle
        view.backgroundColor = .black
        setupNavigationButtons()
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
    
    // MARK: - Actions
    
    private func setupActions() {
        searchButton.addTarget(self, action: #selector(didTapSearch), for: .touchUpInside)
        
        favoriteButton.addTarget(self, action: #selector(didTapFavorite), for: .touchUpInside)
        
        recipeListView.didTapRecipeClosure = { [weak self] indexPath in
            self?.presenter.handleDidSelectRow(at: indexPath)
        }
        
        recipeListView.didTapFavoriteClosure = { [weak self] indexPath in
            self?.presenter.handleDidTapFavorite(at: indexPath)
        }
    }
    
    @objc
    private func didTapSearch() {
        presenter.handleDidTapSearch()
    }
    
    @objc
    private func didTapFavorite() {
        presenter.handleDidTapFavorite()
    }
    
    // MARK: - Layout API
    
    private func setupNavigationButtons() {
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(customView: searchButton),
            UIBarButtonItem(customView: favoriteButton)
        ]
    }
    
    private func addSubviews() {
        view.addSubview(recipeListView)
    }
    
    private func configureConstraints() {
        recipeListView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

// MARK: - RecipeListViewController + RecipeListViewLayer

extension RecipeListViewController: RecipeListViewLayer {
    func reloadData() {
        recipeListView.reloadData()
    }
}
