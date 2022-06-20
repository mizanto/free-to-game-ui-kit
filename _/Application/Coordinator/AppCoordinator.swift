//
//  AppCoordinator.swift
//  free-to-game-ui-kit
//
//  Created by Sergey Bendak on 20.06.2022.
//

import UIKit

final class ApplicationCoordinator: BaseCoordinator {

    private var window: UIWindow
    private var rootNavigationController: UINavigationController
    
    init(window: UIWindow) {
        self.window = window
        self.rootNavigationController = UINavigationController()
    }
    
    override func start() {
        window.makeKeyAndVisible()
        runMainFlow()
    }
    
    private func runMainFlow() {
        let coordinator = CoordinatorFactory.makeMainFlowCoordinator(navigationController: rootNavigationController)
        addDependency(coordinator)
        coordinator.start()
        window.rootViewController = rootNavigationController
    }
    
}
