//
//  GameInfoAssembly.swift
//  free-to-game-ui-kit
//
//  Created by Sergey Bendak on 24.06.2022.
//

import UIKit

final class GameInfoAssembly {
    static func build(title: String?, gameId: Int, api: API) -> UIViewController {
        let viewModel = GameInfoViewModel(api: api, gameId: gameId)
        let viewController = GameInfoViewController()
        viewController.title = title
        viewController.viewModel = viewModel
        return viewController
    }
}
