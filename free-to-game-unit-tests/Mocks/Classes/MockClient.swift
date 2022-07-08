//
//  MockClient.swift
//  free-to-game-unit-tests
//
//  Created by Sergey Bendak on 06.07.2022.
//

import Foundation
@testable import free_to_game_ui_kit

class MockClient: Client {
    var error: Error?
    var games: [ShortGameModel] = []
    var gameInfo: ExtendedGameModel = MockClient.validExtendedGameModel

    func getGames() async throws -> [ShortGameModel] {
        if let error = error {
            throw error
        }
        return games
    }
    
    func getGameInfo(id: Int) async throws -> ExtendedGameModel {
        if let error = error {
            throw error
        }
        return gameInfo
    }
    
    static let validShortGameModels: [ShortGameModel] = [
        ShortGameModel(
            id: 1,
            title: "Title1",
            thumbnail: URL(string: "http://some_url.com")!,
            shortDescription: "Short description 1",
            genre: "Shooter",
            platform: "PC"
        ),
        ShortGameModel(
            id: 2,
            title: "Title2",
            thumbnail: URL(string: "http://some_url.com")!,
            shortDescription: "Short description 2",
            genre: "Shooter",
            platform: "PC"
        )
    ]
    
    static var validCellModels: [GameCellModel] {
        return validShortGameModels.map { $0.toGameCellModel() }
    }
    
    static var validExtendedGameModel: ExtendedGameModel {
        return ExtendedGameModel(
            id: 0,
            title: "title",
            thumbnail: URL(string: "http://some_url.com")!,
            fullDescription: "fullDescription",
            url: URL(string: "http://some_url.com")!,
            genre: "Shooter",
            platform: "PC",
            publisher: "Publisher",
            developer: "Developer",
            releaseDate: "01-01-2022",
            systemRequirements: SystemRequirementsModel(os: "", processor: "", memory: "", graphics: "", storage: ""),
            screenshots: [])
    }
    
    static var validGameInfoModel: GameInfoModel {
        return validExtendedGameModel.toGameInfoModel()
    }
}
