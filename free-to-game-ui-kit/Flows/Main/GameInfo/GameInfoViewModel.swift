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
    private let onShowWeb: (URL) -> ()
    
    private var model: ExtendedGameModel?
    private var subscriptions = Set<AnyCancellable>()
    private var intentSubject = PassthroughSubject<GameInfo.Intent, Never>()
    private var stateSubject = CurrentValueSubject<GameInfo.State, Never>(.loading(NSLocalizedString("game_info.loading.title", comment: "")))
    
    let title: String?
    let requirementsTitle: String = NSLocalizedString("game_info.requirement.title", comment: "")
    let additionalInfoTitle: String = NSLocalizedString("game_info.additional.title", comment: "")
    let screenshotsTitle: String = NSLocalizedString("game_info.screenshots.title", comment: "")
    let actionButtonTitle: String = NSLocalizedString("game_info.action_button", comment: "")
    
    var statePublisher: AnyPublisher<GameInfo.State, Never> {
        return stateSubject.eraseToAnyPublisher()
    }

    init(title: String?, api: API, gameId: Int, onShowWeb: @escaping (URL) -> ()) {
        self.title = title
        self.api = api
        self.gameId = gameId
        self.onShowWeb = onShowWeb
        
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
                case .playNowPressed:
                    self.shwoWebSite()
                case .retry:
                    self.fetchInfo()
                }
            }
            .store(in: &subscriptions)
    }
    
    private func fetchInfo() {
        Task {
            do {
                self.stateSubject.send(.loading(NSLocalizedString("game_info.loading.title", comment: "")))
                self.model = try await self.api.game(by: gameId)
                if let model = self.model {
                    self.stateSubject.send(.value(buildGameInfoModel(from: model)))
                } else {
                    self.stateSubject.send(.error(NSLocalizedString("error.unknown", comment: "")))
                }
            } catch {
                let message = message(for: error)
                self.stateSubject.send(.error(message))
            }
        }
    }
    
    private func message(for error: Error) -> String {
        if let message = (error as? NetworkError)?.errorDescription {
            return message
        } else {
            return NSLocalizedString("error.unknown", comment: "")
        }
    }
    
    private func shwoWebSite() {
        guard let model = model else {
            return
        }
        onShowWeb(model.url)
    }
    
    private func buildGameInfoModel(from model: ExtendedGameModel) -> GameInfoModel {
        var requirementsInfos: [TitledInfo] = []
        if let requirements = model.systemRequirements {
            requirementsInfos = [
                TitledInfo(title: NSLocalizedString("game_info.requirement.os", comment: ""), info: requirements.os),
                TitledInfo(title: NSLocalizedString("game_info.requirement.cpu", comment: ""), info: requirements.processor),
                TitledInfo(title: NSLocalizedString("game_info.requirement.ram", comment: ""), info: requirements.memory),
                TitledInfo(title: NSLocalizedString("game_info.requirement.gpu", comment: ""), info: requirements.graphics),
                TitledInfo(title: NSLocalizedString("game_info.requirement.hdd", comment: ""), info: requirements.storage)
            ]
        }
        return GameInfoModel(
            thumbnailUrl: model.thumbnail,
            platform: model.platform,
            genre: model.genre,
            requirements: requirementsInfos,
            aboutText: model.fullDescription.trimmingCharacters(in: .newlines),
            additionalInfo: [
                TitledInfo(title: NSLocalizedString("game_info.additional.developer", comment: ""), info: model.developer),
                TitledInfo(title: NSLocalizedString("game_info.additional.publisher", comment: ""), info: model.publisher),
                TitledInfo(title: NSLocalizedString("game_info.additional.release_date", comment: ""), info: model.releaseDate)
            ],
            screenshotsUrls: model.screenshots.map { $0.url }
        )
    }
}
