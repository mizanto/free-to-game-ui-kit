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
    var gameInfo: ExtendedGameModel?

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
        return gameInfo!
    }
    
    static let validGames: [ShortGameModel] = [
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
        return validGames.map { $0.toGameCellModel() }
    }
}
