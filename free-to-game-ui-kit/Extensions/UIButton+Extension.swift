//
//  UIButton+Extension.swift
//  free-to-game-ui-kit
//
//  Created by Sergey Bendak on 29.06.2022.
//

import UIKit

extension UIButton {
    func setBacgroundColor(_ color: UIColor, for state: UIControl.State) {
        setBackgroundImage(UIImage.image(with: color), for: state)
    }
}
