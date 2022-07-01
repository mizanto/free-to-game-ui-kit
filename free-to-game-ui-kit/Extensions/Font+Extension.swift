//
//  Font+Extension.swift
//  free-to-game-ui-kit
//
//  Created by Sergey Bendak on 01.07.2022.
//

import UIKit

extension UIFont {
    static var head: UIFont {
        return .systemFont(ofSize: 22, weight: .semibold)
    }
    
    static var title: UIFont {
        return .systemFont(ofSize: 17, weight: .medium)
    }
    
    static var body: UIFont {
        return .systemFont(ofSize: 15, weight: .regular)
    }
    
    static var accent: UIFont {
        return .systemFont(ofSize: 15, weight: .semibold)
    }
}
