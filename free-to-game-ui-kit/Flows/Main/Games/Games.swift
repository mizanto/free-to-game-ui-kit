//
//  Games.swift
//  free-to-game-ui-kit
//
//  Created by Sergey Bendak on 29.06.2022.
//

import Foundation

enum Games {
    enum State {
        case value([GameCellModel])
        case empty(String)
        case loading(String)
        case error(String)
    }
    
    enum Intent {
        case fetchData
        case selectRow(Int)
    }
}
