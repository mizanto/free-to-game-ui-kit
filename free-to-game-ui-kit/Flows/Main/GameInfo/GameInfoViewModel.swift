//
//  GameInfoViewModel.swift
//  free-to-game-ui-kit
//
//  Created by Sergey Bendak on 24.06.2022.
//

import Foundation
import Combine

final class GameInfoViewModel {
    enum State {
        case value(ExtendedGameModel)
        case loading
        case error
    }
    
    private let api: API
    private let gameId: Int
    
    private var model: ExtendedGameModel?
    private var subscriptions = Set<AnyCancellable>()
    private var intentSubject = PassthroughSubject<GameInfoViewController.Intent, Never>()
    private var stateSubject = CurrentValueSubject<State, Never>(.loading)
    
    var statePublisher: AnyPublisher<State, Never> {
        return stateSubject.eraseToAnyPublisher()
    }

    init(api: API, gameId: Int) {
        self.api = api
        self.gameId = gameId
        
        bind()
    }
    
    func sendEvent(_ intent: GameInfoViewController.Intent) {
        intentSubject.send(intent)
    }
    
    private func bind() {
        intentSubject
            .print("ViewModel")
            .sink { [weak self] intent in
                guard let self = self else { return }
                switch intent {
                case .fetchData:
                    self.fetchInfo()
                }
            }
            .store(in: &subscriptions)
    }
    
    private func fetchInfo() {
        Task {
            do {
                self.stateSubject.send(.loading)
                self.model = try await self.api.game(by: gameId)
                if let model = self.model {
                    self.stateSubject.send(.value(model))
                } else {
                    self.stateSubject.send(.error)
                }
            } catch {
                self.stateSubject.send(.error)
            }
        }
    }
}
