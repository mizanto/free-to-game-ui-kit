//
//  UILabel+Extension.swift
//  free-to-game-ui-kit
//
//  Created by Sergey Bendak on 25.06.2022.
//

import UIKit

extension UILabel {
    
    convenience init(text: String? = nil, alignment: NSTextAlignment = .left, font: UIFont = .body, numberOfLines: Int = 1) {
        self.init(frame: .zero)
        self.text = text
        self.textAlignment = alignment
        self.font = font
        self.numberOfLines = numberOfLines
    }
    
    static func head(text: String? = nil, alignment: NSTextAlignment = .left, numberOfLines: Int = 1) -> UILabel {
        return UILabel(text: text, alignment: alignment, font: .head, numberOfLines: numberOfLines)
    }
    
    static func title(text: String? = nil, alignment: NSTextAlignment = .left, numberOfLines: Int = 1) -> UILabel {
        return UILabel(text: text, alignment: alignment, font: .title, numberOfLines: numberOfLines)
    }
    
    static func body(text: String? = nil, alignment: NSTextAlignment = .left, numberOfLines: Int = 1) -> UILabel {
        return UILabel(text: text, alignment: alignment, font: .body, numberOfLines: numberOfLines)
    }
    
    static func accent(text: String? = nil, alignment: NSTextAlignment = .left, numberOfLines: Int = 1) -> UILabel {
        return UILabel(text: text, alignment: alignment, font: .accent, numberOfLines: numberOfLines)
    }
}
