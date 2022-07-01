//
//  UILabel+Extension.swift
//  free-to-game-ui-kit
//
//  Created by Sergey Bendak on 25.06.2022.
//

import UIKit

extension UILabel {
    
    convenience init(text: String? = nil, alignment: NSTextAlignment = .left, font: UIFont = .systemFont(ofSize: 13), numberOfLines: Int = 1) {
        self.init(frame: .zero)
        self.text = text
        self.textAlignment = alignment
        self.font = font
        self.numberOfLines = numberOfLines
    }
    
    @discardableResult
    func setFont(_ font: UIFont) -> UILabel {
        self.font = font
        return self
    }
    
    @discardableResult
    func setNumberofLines(_ numberOfLines: Int) -> UILabel {
        self.numberOfLines = numberOfLines
        return self
    }
}
