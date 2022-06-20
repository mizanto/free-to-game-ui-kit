//
//  CoordinatorFactory.swift
//  free-to-game-ui-kit
//
//  Created by Sergey Bendak on 20.06.2022.
//

import UIKit

final class CoordinatorFactory {
    
    static func makeMainFlowCoordinator(navigationController: UINavigationController) -> Coordinator {
        return MainCoordinator(navigationController: navigationController)
    }
    
}

