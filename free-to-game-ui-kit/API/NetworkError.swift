//
//  NetworkError.swift
//  free-to-game-ui-kit
//
//  Created by Sergey Bendak on 21.06.2022.
//

import Foundation
import SwiftUI

enum NetworkError: Error {
    case badRequest
    case forbiden
    case notFound
    case toManyRequests
    case internalServerError
    case unavailable
    case parsing
    case unknown(Int?)
    
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
