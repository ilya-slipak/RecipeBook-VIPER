//
//  SearchRecipeListViewController.swift
//  RecipeBook
//
//  Created by Ilya Slipak on 28.10.2023.
//

import UIKit

// MARK: - SearchRecipeListViewLayer

protocol SearchRecipeListViewLayer: AnyObject {
    func reloadData()
}

// MARK: - SearchRecipeListViewController

final class SearchRecipeListViewController: UIViewController {
    // MARK: - Views

    private let searchTextField: SearchTextField = .init()

    private let recipeListView: RecipeListView = .init()

    // MARK: - Internal Properties

    var presenter: SearchRecipeListPresenterLayer!

    // MARK: - Lifecycle API

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.getRecipes()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        searchTextField.becomeFirstResponder()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        searchTextField.resignFirstResponder()
    }

    // MARK: - Private API

    private func setupView() {
        title = presenter.navigationTitle
        searchTextField.setPlaceholder(presenter.searchTextFieldPlaceholder)
        searchTextField.delegate = self
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
        searchTextField.addTarget(self, action: #selector(onTextDidChange), for: .editingChanged)

        recipeListView.didTapRecipeClosure = { [weak self] indexPath in
            self?.presenter.handleDidSelectRow(at: indexPath)
        }

        recipeListView.didTapFavoriteClosure = { [weak self] indexPath in
            self?.presenter.handleDidTapFavorite(at: indexPath)
        }
    }

    @objc
    private func hideKeyboard() {
        searchTextField.resignFirstResponder()
    }

    @objc
    private func onTextDidChange(textField: UITextField) {
        let searchQuery = textField.text ?? ""
        presenter.getRecipesConsideringSearch(searchQuery)
    }

    // MARK: - Layout API

    private func addSubviews() {
        view.addSubview(searchTextField)
        view.addSubview(recipeListView)
    }

    private func configureConstraints() {
        searchTextField.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.equalToSuperview().offset(Constants.textFieldHorizontalOffset)
            make.trailing.equalToSuperview().offset(-Constants.textFieldHorizontalOffset)
            make.height.equalTo(Constants.textFieldHeight)
        }
        recipeListView.snp.makeConstraints { make in
            make.top.equalTo(searchTextField.snp.bottom)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}

// MARK: - SearchRecipeListViewController + UITextFieldDelegate

extension SearchRecipeListViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

// MARK: - SearchRecipeListViewController + SearchRecipeListViewLayer

extension SearchRecipeListViewController: SearchRecipeListViewLayer {
    func reloadData() {
        recipeListView.reloadData()
    }
}

// MARK: - SearchRecipeListViewController + Constants

fileprivate extension SearchRecipeListViewController {
    enum Constants {
        static let textFieldHeight: CGFloat = 44

        static let textFieldHorizontalOffset: CGFloat = 24
    }
}
