//
//  URLSessionCompatible.swift
//  free-to-game-ui-kit
//
//  Created by Sergey Bendak on 06.07.2022.
//

import Foundation

protocol URLSessionCompatible {
    func data(for request: URLRequest, delegate: URLSessionTaskDelegate?) async throws -> (Data, URLResponse)
}

extension URLSession: URLSessionCompatible {}
