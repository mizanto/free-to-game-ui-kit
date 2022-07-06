//
//  API+EndPoint.swift
//  free-to-game-ui-kit
//
//  Created by Sergey Bendak on 21.06.2022.
//

import Foundation

extension API {
    enum EndPoint {
        static private let baseUrlString = "https://www.freetogame.com/api/"
        
        case games
        case game(Int)
        
        var url: URL {
            let urlString: String
            switch self {
            case .games:
                urlString = EndPoint.baseUrlString.appending("games")
            case .game(let id):
                urlString = EndPoint.baseUrlString.appending("game?id=\(id)")
            }
            return URL(string: urlString)!
        }
    }
}
