//
//  RoundedButton.swift
//  free-to-game-ui-kit
//
//  Created by Sergey Bendak on 29.06.2022.
//

import UIKit

final class RoundedButton: UIButton {
    private var cornerRadius: CGFloat
    
    init(title: String, backgroundColor: UIColor, cornerRadius: CGFloat) {
        self.cornerRadius = cornerRadius
        super.init(frame: .zero)
        
        setTitle(title, for: .normal)
        setBacgroundColor(backgroundColor, for: .normal)
        setup()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        layer.cornerRadius = cornerRadius
        clipsToBounds = true
    }
}
