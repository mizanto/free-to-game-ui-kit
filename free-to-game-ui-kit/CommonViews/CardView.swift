//
//  CardView.swift
//  free-to-game-ui-kit
//
//  Created by Sergey Bendak on 22.06.2022.
//

import UIKit
import SnapKit

class CardView: UIView {
    
    var cornerRadius: CGFloat = 8
    
    let contentView: UIView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupShadow()
        setupContentView()
    }
    
    private func setupLayout() {
        addSubview(contentView)
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func setupContentView() {
        contentView.layer.cornerRadius = 8
        contentView.layer.masksToBounds = true
    }

    private func setupShadow() {
        layer.cornerRadius = cornerRadius
        layer.shadowOffset = CGSize(width: 0, height: 4)
        layer.shadowRadius = 8
        layer.shadowOpacity = 0.16
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = UIScreen.main.scale
    }
}
