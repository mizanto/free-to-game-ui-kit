//
//  GamesViewModel.swift
//  free-to-game-ui-kit
//
//  Created by Sergey Bendak on 22.06.2022.
//

import Combine
import UIKit

final class GamesViewModel: NSObject {
    private let api: API
    private let onSelect: (String, Int) -> ()
    
    private var stateSubject = CurrentValueSubject<Games.State, Never>(.empty(NSLocalizedString("games.empty.title", comment: "")))
    private var intentSubject = PassthroughSubject<Games.Intent, Never>()
    private var subscriptions = Set<AnyCancellable>()
    
    var title: String? = NSLocalizedString("games.title", comment: "")
    
    var statePublisher: AnyPublisher<Games.State, Never> {
        return stateSubject.eraseToAnyPublisher()
    }
    
    private var models: [ShortGameModel] = []
    
    init(api: API, onSelect: @escaping (String, Int) -> ()) {
        self.api = api
        self.onSelect = onSelect
        super.init()
        
        bind()
    }
    
    func sendEvent(_ intent: Games.Intent) {
        intentSubject.send(intent)
    }
    
    private func bind() {
        intentSubject
            .print("ViewModel")
            .sink { [weak self] intent in
                guard let self = self else { return }
                switch intent {
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
                models = try await api.games()
                if models.isEmpty {
                    stateSubject.send(.empty(NSLocalizedString("games.empty.title", comment: "")))
                } else {
                    let cellModels = models.map { $0.toGameCellModel() }
                    stateSubject.send(.value(cellModels))
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
        let title = models[row].title
        let id = models[row].id
        onSelect(title, id)
    }

}

extension GamesViewModel: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if case let Games.State.value(models) = stateSubject.value {
            return models.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard case let Games.State.value(models) = stateSubject.value else {
            return UITableViewCell()
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: GameCell.identifier, for: indexPath) as! GameCell
        cell.update(with: models[indexPath.row])
        return cell
    }
}
