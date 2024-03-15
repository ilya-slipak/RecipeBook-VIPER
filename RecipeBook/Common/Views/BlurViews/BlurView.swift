//
//  BlurView.swift
//  RecipeBook
//
//  Created by Ilya Slipak on 27.10.2023.
//

import UIKit

// MARK: - BlurView

final class BlurView: UIView {
    // MARK: - Views
    
    private lazy var blurView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        return blurEffectView
    }()
    
    // MARK: - Init
    
    init() {
        super.init(frame: .zero)
        backgroundColor = .clear
        layer.cornerRadius = 12
        clipsToBounds = true
        addSubviews()
        configureConstraints()
    }
    
    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Layout API
    
    private func addSubviews() {
        addSubview(blurView)
    }
    
    private func configureConstraints() {
        blurView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
