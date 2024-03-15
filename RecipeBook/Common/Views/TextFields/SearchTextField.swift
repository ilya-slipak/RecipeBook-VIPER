//
//  SearchTextField.swift
//  RecipeBook
//
//  Created by Ilya Slipak on 29.10.2023.
//

import UIKit

// MARK: - SearchTextField

final class SearchTextField: UITextField {
    // MARK: - Private Properties
    
    private let contentInsets: UIEdgeInsets = .init(top: 8, left: 8, bottom: 8, right: 8)
    
    // MARK: - Init
    
    init() {
        super.init(frame: .zero)
        backgroundColor = .grayCustom
        layer.cornerRadius = 8
        defaultTextAttributes = [
            .font: UIFont.systemFont(ofSize: 16),
            .foregroundColor: UIColor.white,
        ]
    }
    
    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Override API
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: contentInsets)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: contentInsets)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: contentInsets)
    }
    
    // MARK: - Internal API
    
    func setPlaceholder(_ value: String) {
        attributedPlaceholder = NSAttributedString(
            string: value,
            attributes: [
                .font: UIFont.systemFont(ofSize: 16),
                .foregroundColor: UIColor.lightGray,
            ]
        )
    }
}
