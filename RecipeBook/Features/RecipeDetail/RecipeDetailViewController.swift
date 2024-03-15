//
//  RecipeDetailViewController.swift
//  RecipeBook
//
//  Created by Ilya Slipak on 28.10.2023.
//

import UIKit

// MARK: - RecipeDetailViewLayer

protocol RecipeDetailViewLayer: AnyObject {
    func reloadData()
}

// MARK: - RecipeDetailViewController

final class RecipeDetailViewController: UIViewController {
    // MARK: - Views
    
    private let favoriteButton: UIButton = .make(icon: .heartFill)
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.backgroundColor = .clear
        tableView.keyboardDismissMode = .onDrag
        TableViewCellManager.registerCell(IngredientTableViewCell.self, tableView: tableView)
        return tableView
    }()
    
    private let headerView: RecipeHeaderView = .init()
    
    // MARK: - Internal Properties
    
    var presenter: RecipeDetailPresenterLayer!
    
    // MARK: - Lifecycle API
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    // MARK: - Private API
    
    private func setupView() {
        title = presenter.navigationTitle
        view.backgroundColor = .black
        updateFavoriteButton()
        setupNavigationButtons()
        setupTableViewHeader()
        addSubviews()
        configureConstraints()
        setupActions()
    }
    
    private func setupNavigationButtons() {
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(customView: favoriteButton)
        ]
    }
    
    private func setupTableViewHeader() {
        headerView.render(with: presenter.recipe)
        tableView.tableHeaderView = headerView
        tableView.tableHeaderView?.bounds.size = headerView.calculateSize(considering: presenter.recipe)
    }
    
    private func updateFavoriteButton() {
        let recipe = presenter.recipe
        let favoriteIcon: UIImage? = recipe.isFavorite ? .make(icon: .heartFill) : .make(icon: .heart)
        favoriteButton.setImage(favoriteIcon, for: .normal)
    }
    
    // MARK: - Actions API
    
    private func setupActions() {
        favoriteButton.addTarget(self, action: #selector(didTapFavorite), for: .touchUpInside)
    }
    
    @objc
    private func didTapFavorite() {
        presenter.handleDidTapFavorite()
    }
    
    // MARK: - Layout API
    
    private func addSubviews() {
        view.addSubview(tableView)
    }
    
    private func configureConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

// MARK: - RecipeDetailViewController + UITableViewDataSource

extension RecipeDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.recipe.ingredients.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let ingredient = presenter.recipe.ingredients[indexPath.row]
        let cell = TableViewCellManager.dequeueCell(IngredientTableViewCell.self, tableView: tableView, for: indexPath)
        cell.render(with: ingredient)
        return cell
    }
}

// MARK: - RecipeDetailViewController + UITableViewDelegate

extension RecipeDetailViewController: UITableViewDelegate {}

// MARK: - RecipeDetailViewController + RecipeDetailViewLayer

extension RecipeDetailViewController: RecipeDetailViewLayer {
    func reloadData() {
        updateFavoriteButton()
        tableView.reloadData()
    }
}
