//
//  GameInfoAssembly.swift
//  free-to-game-ui-kit
//
//  Created by Sergey Bendak on 24.06.2022.
//

import UIKit

final class GameInfoAssembly {
    static func build(api: API, gameId: Int) -> UIViewController {
        let viewModel = GameInfoViewModel(api: api, gameId: gameId)
        let viewController = GameInfoViewController()
        viewController.viewModel = viewModel
        return viewController
    }
}
