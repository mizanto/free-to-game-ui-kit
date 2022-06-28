//
//  UIStackView+Extension.swift
//  free-to-game-ui-kit
//
//  Created by Sergey Bendak on 24.06.2022.
//

import UIKit

extension UIStackView {
    convenience init(alignment: UIStackView.Alignment = .leading, spacing: CGFloat = 8) {
        self.init(frame: .zero)
        self.alignment = alignment
        self.spacing = spacing
    }
    
    func addArrangedSubviews(_ views: [UIView]) {
        views.forEach { addArrangedSubview($0) }
    }
    
    func removeAllArrangedSubviews() {
        arrangedSubviews.forEach {
            removeArrangedSubview($0)
            NSLayoutConstraint.deactivate($0.constraints)
            $0.removeFromSuperview()
        }
    }
    
    func setViews(_ views: UIView...) {
        removeAllArrangedSubviews()
        addArrangedSubviews(views)
    }
    
    func setView(_ view: UIView) {
        removeAllArrangedSubviews()
        addArrangedSubview(view)
    }
    
    func addViews(_ views: UIView...) {
        addArrangedSubviews(views)
    }
    
    func addView(_ view: UIView) {
        addArrangedSubview(view)
    }
}
