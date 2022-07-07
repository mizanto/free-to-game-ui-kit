//
//  Games.swift
//  free-to-game-ui-kit
//
//  Created by Sergey Bendak on 29.06.2022.
//

import Foundation

enum Games {
    enum State {
        case value(models: [GameCellModel], update: Bool)
        case empty(String)
        case loading(String)
        case error(String)
    }
    
    enum Event {
        case fetchData
        case retry
        case selectRow(Int)
    }
}
