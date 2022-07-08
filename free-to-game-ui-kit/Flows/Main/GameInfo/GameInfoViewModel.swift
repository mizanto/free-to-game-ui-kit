//
//  GameInfoViewModel.swift
//  free-to-game-ui-kit
//
//  Created by Sergey Bendak on 24.06.2022.
//

import Foundation
import Combine

protocol GameInfoViewModelProtocol {
    var title: String? { get }
    var requirementsTitle: String { get }
    var additionalInfoTitle: String { get }
    var screenshotsTitle: String { get }
    var actionButtonTitle: String { get }
    
    var statePublisher: AnyPublisher<ViewState<GameInfoModel>, Never> { get }
    
    func sendEvent(_ event: GameInfoEvent)
}

final class GameInfoViewModel: GameInfoViewModelProtocol {
    // MARK: - GameInfoViewModelProtocol
    let title: String?
    let requirementsTitle: String = NSLocalizedString("game_info.requirement.title", comment: "")
    let additionalInfoTitle: String = NSLocalizedString("game_info.additional.title", comment: "")
    let screenshotsTitle: String = NSLocalizedString("game_info.screenshots.title", comment: "")
    let actionButtonTitle: String = NSLocalizedString("game_info.action_button", comment: "")
    
    var statePublisher: AnyPublisher<ViewState<GameInfoModel>, Never> {
        return stateSubject.eraseToAnyPublisher()
    }
    
    func sendEvent(_ event: GameInfoEvent) {
        eventSubject.send(event)
    }
    
    // MARK: - Private
    private let client: Client
    private let gameId: Int
    private let onShowWeb: (URL) -> ()
    
    private var model: ExtendedGameModel?
    private var subscriptions = Set<AnyCancellable>()
    private var eventSubject = PassthroughSubject<GameInfoEvent, Never>()
    private var stateSubject = CurrentValueSubject<ViewState<GameInfoModel>, Never>(.empty(NSLocalizedString("game_info.empty.title", comment: "")))

    init(title: String?, client: Client, gameId: Int, onShowWeb: @escaping (URL) -> ()) {
        self.title = title
        self.client = client
        self.gameId = gameId
        self.onShowWeb = onShowWeb
        
        bind()
    }
    
    private func bind() {
        eventSubject
            .print("ViewModel")
            .sink { [weak self] event in
                guard let self = self else { return }
                switch event {
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
                self.model = try await self.client.getGameInfo(id: gameId)
                if let model = self.model {
                    self.stateSubject.send(.content(model.toGameInfoModel()))
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
}
