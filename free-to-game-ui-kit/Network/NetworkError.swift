//
//  NetworkError.swift
//  free-to-game-ui-kit
//
//  Created by Sergey Bendak on 21.06.2022.
//

import Foundation

enum NetworkError: LocalizedError, Equatable {
    case badRequest
    case forbiden
    case notFound
    case toManyRequests
    case internalServerError
    case unavailable
    case parsing
    case unknown(Int?)
    
    init(code: Int?) {
        guard let code = code else {
            self = .unknown(nil)
            return
        }
        switch code {
        case 400: self = .badRequest
        case 403: self = .forbiden
        case 404: self = .notFound
        case 429: self = .toManyRequests
        case 500: self = .internalServerError
        case 503: self = .unavailable
        default:  self = .unknown(code)
        }
    }
    
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
}
