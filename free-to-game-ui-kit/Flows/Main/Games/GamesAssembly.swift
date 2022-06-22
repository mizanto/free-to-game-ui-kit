//
//  GamesAssembly.swift
//  free-to-game-ui-kit
//
//  Created by Sergey Bendak on 21.06.2022.
//

import Foundation
import UIKit

class GamesAssembly {

    static func build(api: API) -> UIViewController {
        let viewModel = GamesViewModel(api: api)
        let viewController = GamesViewController()
        viewController.viewModel = viewModel
        return viewController
    }
    
}
