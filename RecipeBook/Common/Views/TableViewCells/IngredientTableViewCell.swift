//
//  IngredientTableViewCell.swift
//  RecipeBook
//
//  Created by Ilya Slipak on 29.10.2023.
//

import UIKit

// MARK: - IngredientTableViewCell

final class IngredientTableViewCell: UITableViewCell {
    // MARK: - Views
    
    private let titleLabel: UILabel = .make(style: .body(textAlignment: .natural))
    
    private let quantityLabel: UILabel = .make(style: .body(textAlignment: .center))
    
    // MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        selectionStyle = .none
        addSubviews()
        configureConstraints()
    }
    
    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
        quantityLabel.text = nil
        updateQuantityLabelWidth(amountText: "")
    }
    
    // MARK: - Internal API
    
    func render(with ingredient: Recipe.Ingredient) {
        titleLabel.text = "- \(ingredient.title)"
        quantityLabel.text = ingredient.amount
        updateQuantityLabelWidth(amountText: ingredient.amount ?? "")
    }
    
    // MARK: - Private API
    
    private func updateQuantityLabelWidth(amountText: String) {
        let quantityLabelSingleLineHeight: CGFloat = 20
        let quantityLabelWidth = amountText.width(constantHeight: quantityLabelSingleLineHeight, font: quantityLabel.font)
        quantityLabel.snp.updateConstraints { make in
            make.width.equalTo(quantityLabelWidth)
        }
    }
    
    // MARK: - Layout API
    
    private func addSubviews() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(quantityLabel)
    }
    
    private func configureConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(Constants.verticalOffset)
            make.leading.equalToSuperview().offset(Constants.horizontalOffset)
            make.bottom.equalToSuperview().offset(-Constants.verticalOffset)
        }
        
        quantityLabel.snp.makeConstraints { make in
            make.centerY.equalTo(titleLabel.snp.centerY)
            make.leading.equalTo(titleLabel.snp.trailing).offset(Constants.interitemOffset)
            make.trailing.equalToSuperview().offset(-Constants.horizontalOffset)
            make.width.equalTo(0)
        }
    }
}

// MARK: - IngredientTableViewCell + Constants

fileprivate extension IngredientTableViewCell {
    enum Constants {
        static let horizontalOffset: CGFloat = 24
        
        static let interitemOffset: CGFloat = 4
        
        static let verticalOffset: CGFloat = 12
    }
}
