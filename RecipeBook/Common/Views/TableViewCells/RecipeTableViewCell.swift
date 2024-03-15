//
//  RecipeTableViewCell.swift
//  RecipeBook
//
//  Created by Ilya Slipak on 26.10.2023.
//

import UIKit

// MARK: - RecipeTableViewCell

final class RecipeTableViewCell: UITableViewCell {
    //MARK: - Views
    
    private let titleLabel: UILabel = .make(style: .bold(textAlignment: .natural))
    
    private let preparationTimeBlurView: BlurView = .init()
    
    private let favoriteBlurViewView: BlurView = .init()
    
    private let preparationTimeLabel: UILabel = .make(style: .regularCentered)
    
    private let recipeImageView: UIImageView = .makeCropped(cornerRadius: 16)
    
    private let favoriteButton: UIButton = .make(icon: .heart)
    
    // MARK: - Internal Properties
    
    var didTapFavoriteClosure: (() -> Void)?
    
    // MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        selectionStyle = .none
        addSubviews()
        configureConstraints()
        setupActions()
    }
    
    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
        preparationTimeLabel.text = nil
        recipeImageView.image = nil
        didTapFavoriteClosure = nil
        favoriteButton.setImage(.make(icon: .heart), for: .normal)
    }
    
    // MARK: - Internal API
    
    func render(with recipe: Recipe) {
        titleLabel.text = recipe.title
        preparationTimeLabel.text = recipe.preparationTime
        recipeImageView.image = UIImage(named: recipe.imageID)
        let isFavourite = recipe.isFavorite
        let favouriteIcon: UIImage? = isFavourite ? .make(icon: .heartFill) : .make(icon: .heart)
        favoriteButton.setImage(favouriteIcon, for: .normal)
    }
    
    // MARK: - Private API
    
    private func setupActions() {
        favoriteButton.addTarget(self, action: #selector(didTapFavorite), for: .touchUpInside)
    }
    
    @objc
    private func didTapFavorite() {
        didTapFavoriteClosure?()
    }
    
    // MARK: - Layout API
    
    private func addSubviews() {
        contentView.addSubview(recipeImageView)
        contentView.addSubview(preparationTimeBlurView)
        contentView.addSubview(favoriteBlurViewView)
        preparationTimeBlurView.addSubview(preparationTimeLabel)
        favoriteBlurViewView.addSubview(favoriteButton)
        contentView.addSubview(titleLabel)
    }
    
    private func configureConstraints() {
        recipeImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(Constants.imageTopOffset)
            make.leading.equalToSuperview().offset(Constants.horizontalOffset)
            make.trailing.equalToSuperview().offset(-Constants.horizontalOffset)
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
        
        favoriteBlurViewView.snp.makeConstraints { make in
            make.trailing.equalTo(recipeImageView.snp.trailing).offset(-Constants.nestedInImageItemOffset)
            make.bottom.equalTo(recipeImageView.snp.bottom).offset(-Constants.nestedInImageItemOffset)
        }
        
        favoriteButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(Constants.itemInBlurViewOffset)
            make.leading.equalToSuperview().offset(Constants.itemInBlurViewOffset)
            make.trailing.equalToSuperview().offset(-Constants.itemInBlurViewOffset)
            make.bottom.equalToSuperview().offset(-Constants.itemInBlurViewOffset)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(recipeImageView.snp.bottom).offset(Constants.titleLabelTopOffset)
            make.leading.equalToSuperview().offset(Constants.titleLabelLeadingOffset)
            make.trailing.equalToSuperview().offset(-Constants.horizontalOffset)
            make.bottom.equalToSuperview().offset(-Constants.titleLabelBottomOffset)
        }
    }
}

// MARK: - RecipeTableViewCell + Constants

fileprivate extension RecipeTableViewCell {
    enum Constants {
        static let horizontalOffset: CGFloat = 20
        
        static let imageHeight: CGFloat = 220
        
        static let imageTopOffset: CGFloat = 14
        
        static let titleLabelTopOffset: CGFloat = 10
        
        static let titleLabelLeadingOffset: CGFloat = 28
        
        static let titleLabelBottomOffset: CGFloat = 14
        
        static let nestedInImageItemOffset: CGFloat = 10
        
        static let itemInBlurViewOffset: CGFloat = 6
    }
}
