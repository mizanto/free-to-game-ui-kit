//
//  GameInfoModel.swift
//  free-to-game-ui-kit
//
//  Created by Sergey Bendak on 28.06.2022.
//

import Foundation

struct GameInfoModel {
    let thumbnailUrl: URL
    let platform: String
    let genre: String
    let requirements: [TitledInfo]
    let aboutText: String
    let additionalInfo: [TitledInfo]
    let screenshotsUrls: [URL]
}
