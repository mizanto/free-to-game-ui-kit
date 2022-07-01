//
//  NetworkError.swift
//  free-to-game-ui-kit
//
//  Created by Sergey Bendak on 21.06.2022.
//

import Foundation

enum NetworkError: LocalizedError {
    case badRequest
    case forbiden
    case notFound
    case toManyRequests
    case internalServerError
    case unavailable
    case parsing
    case unknown(Int?)
    
    var errorDescription: String? {
        switch self {
        case .badRequest, .notFound, .internalServerError, .unavailable, .parsing:
            return NSLocalizedString("error.network.default", comment: "")
        case .forbiden:
            return NSLocalizedString("error.network.vpn", comment: "")
        case .toManyRequests:
            return NSLocalizedString("error.network.many_requests", comment: "")
        case .unknown(_):
            return NSLocalizedString("error.unknown", comment: "")
        }
    }
    
    static func error(code: Int) -> NetworkError {
        switch code {
        case 400: return .badRequest
        case 403: return .forbiden
        case 404: return .notFound
        case 429: return .toManyRequests
        case 500: return .internalServerError
        case 503: return .unavailable
        default:  return .unknown(code)
        }
    }
}
