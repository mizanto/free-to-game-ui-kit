//
//  MockSession.swift
//  free-to-game-unit-tests
//
//  Created by Sergey Bendak on 06.07.2022.
//

import Foundation
@testable import free_to_game_ui_kit

class MockSession: URLSessionCompatible {
    var data: Data
    var response: HTTPURLResponse
    
    init(data: Data, response: HTTPURLResponse) {
        self.data = data
        self.response = response
    }
    
    func data(for request: URLRequest, delegate: URLSessionTaskDelegate?) async throws -> (Data, URLResponse) {
        return (data, response)
    }
}
