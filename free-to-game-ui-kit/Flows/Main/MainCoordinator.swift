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
        let vc = GamesAssembly.build(
            api: api,
            onSelect: { [weak self] id in
                guard let self = self else { return }
                self.showGameInfo(id: id)
            }
        )
        setRootViewController(vc)
    }
    
    private func showGameInfo(id: Int) {
        print("GAME INFO: \(id)")
    }
    
    private func showEmptyScreen() {
        let vc = EmptyViewControllerAssembly.build()
        setRootViewController(vc)
    }
}
