//
//  MainCoordinator.swift
//  free-to-game-ui-kit
//
//  Created by Sergey Bendak on 20.06.2022.
//

import UIKit

final class MainCoordinator: BaseCoordinator {
    
    private let navigationController: UINavigationController
    
    private let api: API = API()
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    override func start() {
        showGamesScreen()
    }
    
    private func setRootViewController(_ viewController: UIViewController) {
        navigationController.setViewControllers([viewController], animated: false)
    }
    
    private func showGamesScreen() {
        let vc = GamesAssembly.build(api: api)
        setRootViewController(vc)
    }
    
    private func showEmptyScreen() {
        let vc = EmptyViewControllerAssembly.build()
        setRootViewController(vc)
    }
}
