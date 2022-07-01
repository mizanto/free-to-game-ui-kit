//
//  RoundedButton.swift
//  free-to-game-ui-kit
//
//  Created by Sergey Bendak on 29.06.2022.
//

import UIKit

final class PrimaryButton: UIButton {
    static let height: CGFloat = 48
    
    init(title: String) {
        super.init(frame: .zero)
        
        setTitle(title, for: .normal)
        setup()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        setBacgroundColor(UIColor(hex: "#5D5FEF")!, for: .normal)
        layer.cornerRadius = 8
        clipsToBounds = true
        
        snp.makeConstraints { make in
            make.height.equalTo(PrimaryButton.height)
        }
    }
}
