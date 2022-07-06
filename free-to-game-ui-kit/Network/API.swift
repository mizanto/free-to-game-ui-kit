//
//  API.swift
//  free-to-game-ui-kit
//
//  Created by Sergey Bendak on 21.06.2022.
//

import Foundation
import Combine

struct API {
    enum Constants {
        static let timeoutInterval = 30.0
    }
    
    private let decoder = JSONDecoder()
    private let apiQueue = DispatchQueue(label: "API", qos: .default, attributes: .concurrent)
    
    private func sendRequest<T: Codable>(endpoint: EndPoint) async throws -> T {
        let request = URLRequest(url: endpoint.url, timeoutInterval: Constants.timeoutInterval)
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let statusCode = (response as? HTTPURLResponse)?.statusCode else {
            throw NetworkError(code: nil)
        }
        
        if 200..<300 ~= statusCode {
            do {
                return try decoder.decode(T.self, from: data)
            } catch {
                throw NetworkError.parsing
            }
        } else {
            throw NetworkError(code: statusCode)
        }
    }
    
    func games() async throws -> [ShortGameModel] {
        return try await sendRequest(endpoint: .games)
    }
    
    func game(by id: Int) async throws -> ExtendedGameModel {
        return try await sendRequest(endpoint: .game(id))
    }
}
