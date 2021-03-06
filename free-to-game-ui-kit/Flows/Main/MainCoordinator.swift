//
//  MainCoordinator.swift
//  free-to-game-ui-kit
//
//  Created by Sergey Bendak on 20.06.2022.
//

import UIKit

final class MainCoordinator: BaseCoordinator {
    private let navigationController: UINavigationController
    private let client: Client = NetworkClient()
    
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
            client: client,
            onSelect: { [weak self] title, id  in
                guard let self = self else { return }
                self.showGameInfo(title: title, id: id)
            }
        )
        setRootViewController(vc)
    }
    
    private func showGameInfo(title: String?, id: Int) {
        let viewController = GameInfoAssembly.build(
            title: title,
            gameId: id,
            client: client,
            onShowWeb: { [weak self] url in
                guard let self = self else { return }
                self.showWebInfo(url: url)
            }
        )
        navigationController.pushViewController(viewController, animated: true)
    }
    
    private func showWebInfo(url: URL) {
        let viewController = WebViewAssembly.build(url: url)
        navigationController.pushViewController(viewController, animated: true)
    }
}
