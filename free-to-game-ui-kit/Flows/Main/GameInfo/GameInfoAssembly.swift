//
//  GameInfoAssembly.swift
//  free-to-game-ui-kit
//
//  Created by Sergey Bendak on 24.06.2022.
//

import UIKit

final class GameInfoAssembly {
    static func build(title: String?, gameId: Int, client: Client, onShowWeb: @escaping (URL) -> ()) -> UIViewController {
        let viewModel = GameInfoViewModel(title: title, client: client, gameId: gameId, onShowWeb: onShowWeb)
        let viewController = GameInfoViewController()
        viewController.viewModel = viewModel
        return viewController
    }
}
