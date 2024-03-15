//
//  RecipeHeaderView.swift
//  RecipeBook
//
//  Created by Ilya Slipak on 29.10.2023.
//

import UIKit

// MARK: - RecipeHeaderView

final class RecipeHeaderView: UIView {
    // MARK: - View

    private let recipeImageView: UIImageView = .makeCropped()

    private let preparationTimeBlurView: BlurView = .init()

    private let preparationTimeLabel: UILabel = .make(style: .regularCentered)

    private let titleLabel: UILabel = .make(style: .bold(textAlignment: .natural))

    private let descriptionLabel: UILabel = .make(style: .body(textAlignment: .natural))

    private let ingredientsLabel: UILabel = .make(style: .bold(textAlignment: .natural))

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

    func render(with recipe: Recipe) {
        recipeImageView.image = UIImage(named: recipe.imageID)
        titleLabel.text = recipe.title
        preparationTimeLabel.text = recipe.preparationTime
        descriptionLabel.text = recipe.description
        ingredientsLabel.text = Constants.ingredientText
    }

    // MARK: - Layout API

    private func addSubviews() {
        addSubview(recipeImageView)
        addSubview(preparationTimeBlurView)
        addSubview(titleLabel)
        addSubview(descriptionLabel)
        addSubview(ingredientsLabel)
        preparationTimeBlurView.addSubview(preparationTimeLabel)
    }

    private func configureConstraints() {
        recipeImageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(Constants.imageHeight)
        }

        preparationTimeBlurView.snp.makeConstraints { make in
            make.top.equalTo(recipeImageView.snp.top).offset(Constants.nestedInImageItemOffset)
            make.leading.equalTo(recipeImageView.snp.leading).offset(Constants.nestedInImageItemOffset)
        }

        preparationTimeLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(Constants.itemInBlurViewOffset)
            make.leading.equalToSuperview().offset(Constants.itemInBlurViewOffset)
            make.trailing.equalToSuperview().offset(-Constants.itemInBlurViewOffset)
            make.bottom.equalToSuperview().offset(-Constants.itemInBlurViewOffset)
        }

        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(recipeImageView.snp.bottom).offset(Constants.labelVerticalOffset)
            make.leading.equalToSuperview().offset(Constants.labelHorizontalOffset)
            make.trailing.equalToSuperview().offset(-Constants.labelHorizontalOffset)
        }

        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(Constants.labelVerticalOffset)
            make.leading.equalTo(titleLabel.snp.leading)
            make.trailing.equalTo(titleLabel.snp.trailing)
        }

        ingredientsLabel.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(Constants.labelVerticalOffset)
            make.leading.equalTo(titleLabel.snp.leading)
            make.trailing.equalTo(titleLabel.snp.trailing)
            make.bottom.equalToSuperview().offset(-Constants.ingredientLabelBottomOffset)
        }
    }
}

// MARK: - Size Calculation

extension RecipeHeaderView {
    func calculateSize(considering recipe: Recipe) -> CGSize {
        let screenWidth = UIScreen.main.bounds.width

        let labelWidth = screenWidth - (Constants.labelHorizontalOffset * 2)

        let imageHeight = Constants.imageHeight

        let titleHeight = recipe.title.height(constantWidth: screenWidth, font: titleLabel.font)

        let descriptionLabelHeight = recipe.description.height(constantWidth: labelWidth, font: descriptionLabel.font)

        let ingredientLabelHeight = Constants.ingredientText.height(constantWidth: labelWidth, font: ingredientsLabel.font)

        let contentHeight = imageHeight 
        + Constants.labelVerticalOffset
        + titleHeight
        + Constants.labelVerticalOffset
        + descriptionLabelHeight
        + Constants.labelVerticalOffset
        + ingredientLabelHeight
        + Constants.ingredientLabelBottomOffset

        return .init(width: screenWidth, height: contentHeight)
    }
}

// MARK: - RecipeHeaderView + Constants

fileprivate extension RecipeHeaderView {
    enum Constants {
        static let imageHeight: CGFloat = 350

        static let labelVerticalOffset: CGFloat = 20

        static let labelHorizontalOffset: CGFloat = 10

        static let nestedInImageItemOffset: CGFloat = 10

        static let itemInBlurViewOffset: CGFloat = 6

        static let ingredientLabelBottomOffset: CGFloat = 8

        static let ingredientText: String = "Ingredients"
    }
}
