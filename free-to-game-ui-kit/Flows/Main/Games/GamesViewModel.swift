//
//  GamesViewModel.swift
//  free-to-game-ui-kit
//
//  Created by Sergey Bendak on 22.06.2022.
//

import Combine
import UIKit

protocol GamesViewModelProtocol: UITableViewDataSource {
    var title: String? { get }
    var statePublisher: AnyPublisher<ViewState<[GameCellModel]>, Never> { get }
    
    func sendEvent(_ event: GamesEvent)
}

final class GamesViewModel: NSObject, GamesViewModelProtocol {
    
    // MARK: - GamesViewModelProtocol
    var title: String? = NSLocalizedString("games.title", comment: "")
    var statePublisher: AnyPublisher<ViewState<[GameCellModel]>, Never> {
        return stateSubject.eraseToAnyPublisher()
    }
    
    func sendEvent(_ event: GamesEvent) {
        eventSubject.send(event)
    }
    
    // MARK: - Private
    private let client: Client
    private let onSelect: (String, Int) -> ()
    
    private var stateSubject = CurrentValueSubject<ViewState<[GameCellModel]>, Never>(.empty(NSLocalizedString("games.empty.title", comment: "")))
    private var eventSubject = PassthroughSubject<GamesEvent, Never>()
    private var subscriptions = Set<AnyCancellable>()
    
    private var models: [ShortGameModel] = []
    
    init(client: Client, onSelect: @escaping (String, Int) -> ()) {
        self.client = client
        self.onSelect = onSelect
        super.init()
        
        bind()
    }
    
    private func bind() {
        eventSubject
            .print("ViewModel")
            .sink { [weak self] event in
                guard let self = self else { return }
                switch event {
                case .fetchData:
                    self.fetchGames()
                case .selectRow(let row):
                    self.select(row: row)
                case .retry:
                    self.fetchGames()
                }
            }
            .store(in: &subscriptions)
    }
    
    private func fetchGames() {
        Task {
            do {
                stateSubject.send(.loading(NSLocalizedString("games.loading.title", comment: "")))
                models = try await client.getGames()
                if models.isEmpty {
                    stateSubject.send(.empty(NSLocalizedString("games.empty.title", comment: "")))
                } else {
                    let cellModels = models.map { $0.toGameCellModel() }
                    stateSubject.send(.content(cellModels))
                }
            } catch {
                let message = message(for: error)
                stateSubject.send(.error(message))
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
    
    private func select(row: Int) {
        if models.isEmpty { return }
        let title = models[row].title
        let id = models[row].id
        onSelect(title, id)
    }

}

extension GamesViewModel: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if case let .content(models) = stateSubject.value {
            return models.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard case let .content(models) = stateSubject.value else {
            return UITableViewCell()
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: GameCell.identifier, for: indexPath) as! GameCell
        cell.update(with: models[indexPath.row])
        return cell
    }
}
