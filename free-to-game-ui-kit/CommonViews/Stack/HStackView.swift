//
//  HStackView.swift
//  free-to-game-ui-kit
//
//  Created by Sergey Bendak on 25.06.2022.
//

import UIKit

final class HStackView: UIStackView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        axis = .horizontal
    }
    
    @available(*, unavailable)
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
