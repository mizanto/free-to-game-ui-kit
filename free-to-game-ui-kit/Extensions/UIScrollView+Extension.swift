//
//  UIScrollView+Extension.swift
//  free-to-game-ui-kit
//
//  Created by Sergey Bendak on 28.06.2022.
//

import UIKit

extension UIScrollView {
    convenience init(showsHorizontalIndicator: Bool = false, showsVerticalIndicator: Bool = false) {
        self.init(frame: .zero)
        self.showsHorizontalScrollIndicator = showsHorizontalIndicator
        self.showsVerticalScrollIndicator = showsVerticalIndicator
    }
}
