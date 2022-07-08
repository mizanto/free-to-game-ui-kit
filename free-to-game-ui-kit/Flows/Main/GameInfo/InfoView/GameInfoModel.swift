//
//  GameInfoModel.swift
//  free-to-game-ui-kit
//
//  Created by Sergey Bendak on 28.06.2022.
//

import Foundation

struct GameInfoModel: Equatable {
    let thumbnailUrl: URL
    let platform: String
    let genre: String
    let requirements: [TitledInfo]
    let aboutText: String
    let additionalInfo: [TitledInfo]
    let screenshotsUrls: [URL]
}

extension ExtendedGameModel {
    func toGameInfoModel() -> GameInfoModel {
        var requirementsInfos: [TitledInfo] = []
        if let requirements = systemRequirements {
            requirementsInfos = [
                TitledInfo(title: NSLocalizedString("game_info.requirement.os", comment: ""), info: requirements.os),
                TitledInfo(title: NSLocalizedString("game_info.requirement.cpu", comment: ""), info: requirements.processor),
                TitledInfo(title: NSLocalizedString("game_info.requirement.ram", comment: ""), info: requirements.memory),
                TitledInfo(title: NSLocalizedString("game_info.requirement.gpu", comment: ""), info: requirements.graphics),
                TitledInfo(title: NSLocalizedString("game_info.requirement.hdd", comment: ""), info: requirements.storage)
            ]
        }
        return GameInfoModel(
            thumbnailUrl: thumbnail,
            platform: platform,
            genre: genre,
            requirements: requirementsInfos,
            aboutText: fullDescription.trimmingCharacters(in: .newlines),
            additionalInfo: [
                TitledInfo(title: NSLocalizedString("game_info.additional.developer", comment: ""), info: developer),
                TitledInfo(title: NSLocalizedString("game_info.additional.publisher", comment: ""), info: publisher),
                TitledInfo(title: NSLocalizedString("game_info.additional.release_date", comment: ""), info: releaseDate)
            ],
            screenshotsUrls: screenshots.map { $0.url }
        )
    }
}
