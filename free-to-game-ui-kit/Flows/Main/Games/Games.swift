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
        case empty
        case loading
        case error
    }
    
    enum Intent {
        case fetchData
        case selectRow(Int)
    }
}
