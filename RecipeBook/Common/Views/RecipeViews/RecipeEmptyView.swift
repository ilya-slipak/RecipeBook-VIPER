//
//  RecipeEmptyView.swift
//  RecipeBook
//
//  Created by Ilya Slipak on 28.10.2023.
//

import UIKit

// MARK: - RecipeEmptyView

final class RecipeEmptyView: UIView {
    // MARK: - Views
    
    private let titleLabel: UILabel = .make(style: .bold(textAlignment: .center))
    
    // MARK: - Init
    
    init(with title: String) {
        super.init(frame: .zero)
        backgroundColor = .clear
        addSubviews()
        configureConstraints()
        titleLabel.text = title
    }
    
    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Layout API
    
    private func addSubviews() {
        addSubview(titleLabel)
    }
    
    private func configureConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.greaterThanOrEqualToSuperview()
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.lessThanOrEqualToSuperview()
        }
    }
}
