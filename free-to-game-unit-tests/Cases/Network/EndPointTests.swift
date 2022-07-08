//
//  EndPointTests.swift
//  free-to-game-unit-tests
//
//  Created by Sergey Bendak on 06.07.2022.
//

import XCTest
@testable import free_to_game_ui_kit

class EndPointTests: XCTestCase {
    
    func test_EndPoint_url_whenGames() {
        // given
        let expected = URL(string: "https://www.freetogame.com/api/games")
        // when
        let endPoint = EndPoint.games
        // then
        XCTAssertEqual(endPoint.url, expected)
    }
    
    func test_EndPoint_url_whenGame() {
        // given
        let expected = URL(string: "https://www.freetogame.com/api/game?id=1")
        // when
        let endPoint = EndPoint.game(1)
        // then
        XCTAssertEqual(endPoint.url, expected)
    }
}
