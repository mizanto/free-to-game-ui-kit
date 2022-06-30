//
//  ShadowView.swift
//  free-to-game-ui-kit
//
//  Created by Sergey Bendak on 29.06.2022.
//

import UIKit

final class ShadowView: UIView {
    init(shadowOffset: CGSize, shadowRadius: CGFloat, shadowOpacity: Float) {
        super.init(frame: .zero)
        setup(shadowOffset: shadowOffset, shadowRadius: shadowRadius, shadowOpacity: shadowOpacity)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup(shadowOffset: CGSize, shadowRadius: CGFloat, shadowOpacity: Float) {
        layer.shadowOffset = shadowOffset
        layer.shadowRadius = shadowRadius
        layer.shadowOpacity = shadowOpacity
    }
}
