//
//  GameInfo.swift
//  free-to-game-ui-kit
//
//  Created by Sergey Bendak on 29.06.2022.
//

import Foundation

enum GameInfo {
    enum Intent {
        case fetchData
    }
    
    enum State {
        case value(GameInfoModel)
        case loading
        case error
    }
}
