//
//  GameCellModel.swift
//  free-to-game-ui-kit
//
//  Created by Sergey Bendak on 22.06.2022.
//

import Foundation

struct GameCellModel {
    let thumbnailUrl: URL
    let title: String
    let info: String
    let platform: String
    let genre: String
}

extension ShortGameModel {
    func toGameCellModel() -> GameCellModel {
        return GameCellModel(
            thumbnailUrl: thumbnail,
            title: title,
            info: shortDescription,
            platform: platform,
            genre: genre
        )
    }
}
