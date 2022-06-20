//
//  MainCoordinator.swift
//  free-to-game-ui-kit
//
//  Created by Sergey Bendak on 20.06.2022.
//

import UIKit

final class MainCoordinator: BaseCoordinator {
    
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    override func start() {
        showScreen()
    }
    
    private func showScreen() {
        let vc = EmptyViewControllerAssembly.build()
        navigationController.setViewControllers([vc], animated: false)
    }
}
