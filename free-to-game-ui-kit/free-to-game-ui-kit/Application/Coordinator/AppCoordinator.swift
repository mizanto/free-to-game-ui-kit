//
//  AppCoordinator.swift
//  free-to-game-ui-kit
//
//  Created by Sergey Bendak on 20.06.2022.
//

import UIKit

final class AppCoordinator: BaseCoordinator {

    private var window: UIWindow
    private var scene: UIWindowScene
    
    init(scene: UIWindowScene) {
        self.scene = scene
        self.window = UIWindow(frame: UIScreen.main.bounds)
    }
    
    override func start() {
        window.windowScene = scene
        window.makeKeyAndVisible()
        runMainFlow()
    }
    
    private func runMainFlow() {
        let navController = UINavigationController()
        let coordinator = CoordinatorFactory.makeMainFlowCoordinator(navigationController: navController)
        addDependency(coordinator)
        coordinator.start()
        window.rootViewController = navController
    }
    
}

