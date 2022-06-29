//
//  GameInfoViewModel.swift
//  free-to-game-ui-kit
//
//  Created by Sergey Bendak on 24.06.2022.
//

import Foundation
import Combine

final class GameInfoViewModel {
    private let api: API
    private let gameId: Int
    
    private var model: ExtendedGameModel?
    private var subscriptions = Set<AnyCancellable>()
    private var intentSubject = PassthroughSubject<GameInfo.Intent, Never>()
    private var stateSubject = CurrentValueSubject<GameInfo.State, Never>(.loading)
    
    var statePublisher: AnyPublisher<GameInfo.State, Never> {
        return stateSubject.eraseToAnyPublisher()
    }

    init(api: API, gameId: Int) {
        self.api = api
        self.gameId = gameId
        
        bind()
    }
    
    func sendEvent(_ intent: GameInfo.Intent) {
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
                    self.stateSubject.send(.value(buildGameInfoModel(from: model)))
                } else {
                    self.stateSubject.send(.error)
                }
            } catch {
                self.stateSubject.send(.error)
            }
        }
    }
    
    private func buildGameInfoModel(from model: ExtendedGameModel) -> GameInfoModel {
        var requirementsInfos: [TitledInfo] = []
        if let requirements = model.systemRequirements {
            requirementsInfos = [
                TitledInfo(title: "OS", info: requirements.os),
                TitledInfo(title: "CPU", info: requirements.processor),
                TitledInfo(title: "RAM", info: requirements.memory),
                TitledInfo(title: "GPU", info: requirements.graphics),
                TitledInfo(title: "HDD", info: requirements.storage)
            ]
        }
        return GameInfoModel(
            thumbnailUrl: model.thumbnail,
            platform: model.platform,
            genre: model.genre,
            requirements: requirementsInfos,
            aboutText: model.fullDescription.trimmingCharacters(in: .newlines),
            additionInfo: [
                TitledInfo(title: "Developer", info: model.developer),
                TitledInfo(title: "Publisher", info: model.publisher),
                TitledInfo(title: "Release Date", info: model.releaseDate)
            ],
            screenshotsUrls: model.screenshots.map { $0.url }
        )
    }
}
