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
    
    private func sendRequest<T: Codable>(endPoint: EndPoint) -> AnyPublisher<T, Error> {
        let request = URLRequest(url: endPoint.url, timeoutInterval: Constants.timeoutInterval)
        return URLSession.shared.dataTaskPublisher(for: request)
            .retry(1)
            .receive(on: apiQueue)
            .print("--")
            .tryMap({ data, response in
                print("DATA: \(data)")
                guard let httpResponse = response as? HTTPURLResponse,
                        httpResponse.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                return data
            })
            .decode(type: T.self, decoder: decoder)
            .mapError { error -> Error in
                print(error)
                switch error {
                case is URLError: return .network
                case is DecodingError: return .parsing
                default: return .unknown
                }
            }
            .eraseToAnyPublisher()
    }
    
    func games() -> AnyPublisher<[ShortGameModel], Error> {
        return sendRequest(endPoint: .games)
    }
    
    func game(id: Int) -> AnyPublisher<ExtendedGameModel, Error> {
        return sendRequest(endPoint: .game(id))
    }
}
