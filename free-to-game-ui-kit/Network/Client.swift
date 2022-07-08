//
//  Client.swift
//  free-to-game-ui-kit
//
//  Created by Sergey Bendak on 21.06.2022.
//

import Foundation
import Combine

protocol Client {
    func getGames() async throws -> [ShortGameModel]
    func getGameInfo(id: Int) async throws -> ExtendedGameModel
}

struct NetworkClient: Client {
    private enum Constants {
        static let timeoutInterval = 30.0
    }
    
    private let session: URLSessionCompatible
    private let decoder = JSONDecoder()
    
    init(session: URLSessionCompatible = URLSession.shared) {
        self.session = session
    }
    
    func getGames() async throws -> [ShortGameModel] {
        return try await get(endpoint: .games)
    }
    
    func getGameInfo(id: Int) async throws -> ExtendedGameModel {
        return try await get(endpoint: .game(id))
    }
    
    func sendRequest(endpoint: EndPoint) async throws -> Data {
        print("Request URL: \(endpoint.url)")
        let request = URLRequest(url: endpoint.url, timeoutInterval: Constants.timeoutInterval)
        
        let (data, response) = try await session.data(for: request, delegate: nil)
        
        guard let statusCode = (response as? HTTPURLResponse)?.statusCode else {
            throw NetworkError(code: nil)
        }
        
        print("Response status code: \(statusCode)")
        if 200 == statusCode {
            return data
        } else {
            throw NetworkError(code: statusCode)
        }
    }
    
    private func get<T: Codable>(endpoint: EndPoint) async throws -> T {
        do {
            let data = try await sendRequest(endpoint: endpoint)
            return try decoder.decode(T.self, from: data)
        } catch is DecodingError {
            throw NetworkError.parsing
        } catch {
            throw error
        }
    }
}

//DecodingError
