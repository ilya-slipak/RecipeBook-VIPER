//
//  RecipeListView.swift
//  RecipeBook
//
//  Created by Ilya Slipak on 27.10.2023.
//

import UIKit

// MARK: - RecipeListView

final class RecipeListView: UIView {
    // MARK: - Views
    
    private lazy var tableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.backgroundColor = .clear
        tableView.keyboardDismissMode = .onDrag
        TableViewCellManager.registerCell(RecipeTableViewCell.self, tableView: tableView)
        return tableView
    }()
    
    // MARK: - Private Properties
    
    var recipesCountClosure: (() -> Int)?
    
    var recipeClosure: ((_ indexPath: IndexPath) -> Recipe)?
    
    var didTapRecipeClosure: ((_ indexPath: IndexPath) -> Void)?
    
    var didTapFavoriteClosure: ((_ indexPath: IndexPath) -> Void)?
    
    // MARK: - Init
    
    init() {
        super.init(frame: .zero)
        backgroundColor = .clear
        addSubviews()
        configureConstraints()
    }
    
    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Internal API
    
    func reloadData() {
        updateEmptyView()
        tableView.reloadData()
    }
    
    // MARK: - Private API
    
    private func updateEmptyView() {
        let recipesCount = recipesCountClosure?() ?? 0
        
        guard recipesCount == 0 else { 
            tableView.removeEmptyView()
            return
        }
        
        tableView.addEmptyView(.recipe)
    }
    
    // MARK: - Layout API
    
    private func addSubviews() {
        addSubview(tableView)
    }
    
    private func configureConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

// MARK: - RecipeListView + UITableViewDataSource

extension RecipeListView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        recipesCountClosure?() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let recipe = recipeClosure?(indexPath) ?? .makeDummy()
        let cell = TableViewCellManager.dequeueCell(RecipeTableViewCell.self, tableView: tableView, for: indexPath)
        cell.render(with: recipe)
        cell.didTapFavoriteClosure = { [weak self] in
            guard let indexPath = tableView.indexPath(for: cell) else { 
                return
            }
            
            self?.didTapFavoriteClosure?(indexPath)
        }
        return cell
    }
}

// MARK: - RecipeListView + UITableViewDelegate

extension RecipeListView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        didTapRecipeClosure?(indexPath)
    }
}
