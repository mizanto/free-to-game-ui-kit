//
//  GamesAssembly.swift
//  free-to-game-ui-kit
//
//  Created by Sergey Bendak on 21.06.2022.
//

import Foundation
import UIKit

final class GamesAssembly {
    static func build(client: Client, onSelect: @escaping (String, Int) -> ()) -> UIViewController {
        let viewModel = GamesViewModel(client: client, onSelect: onSelect)
        let viewController = GamesViewController()
        viewController.viewModel = viewModel
        return viewController
    }
}
