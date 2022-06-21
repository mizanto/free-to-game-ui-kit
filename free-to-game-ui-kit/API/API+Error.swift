//
//  API+Error.swift
//  free-to-game-ui-kit
//
//  Created by Sergey Bendak on 21.06.2022.
//

import Foundation

extension API {
    enum Error: LocalizedError, Identifiable {
        var id: String { localizedDescription }
        
        case network
        case parsing
        case unknown
        
        var errorDescription: String? {
            switch self {
            case .network: return "Request to API Server failed"
            case .parsing: return "Failed parsing response from server"
            case .unknown: return "An unknown error occurred"
            }
        }
    }
}
