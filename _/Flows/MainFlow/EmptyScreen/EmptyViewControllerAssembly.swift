//
//  EmptyViewControllerAssembly.swift
//  free-to-game-ui-kit
//
//  Created by Sergey Bendak on 20.06.2022.
//

import UIKit

/// Every screen have own factory that builds screen and hides it under UIViewController.
final class EmptyViewControllerAssembly {
    
    /// Inside it's possible to use MVC/MVP/MVVM/VIPER architecture, outside it's just UIViewController.
    static func build() -> UIViewController {
        let vc = EmptyViewController()
        return vc
    }
    
}
