//
//  GamesViewModel.swift
//  free-to-game-ui-kit
//
//  Created by Sergey Bendak on 22.06.2022.
//

import Combine
import UIKit

final class GamesViewModel: NSObject {
    enum State {
        case value([GameCellModel])
        case empty
        case loading
        case error
    }
    
    private let api: API
    private let onSelect: (Int) -> ()
    
    private var stateSubject = CurrentValueSubject<State, Never>(.empty)
    private var intentSubject = PassthroughSubject<GamesViewController.Intent, Never>()
    private var subscriptions = Set<AnyCancellable>()
    
    var statePublisher: AnyPublisher<State, Never> {
        return stateSubject.eraseToAnyPublisher()
    }
    
    private var models: [ShortGameModel] = []
    
    init(api: API, onSelect: @escaping (Int) -> ()) {
        self.api = api
        self.onSelect = onSelect
        super.init()
        
        bind()
    }
    
    func sendEvent(_ intent: GamesViewController.Intent) {
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
                }
            }
            .store(in: &subscriptions)
    }
    
    private func fetchGames() {
        Task {
            do {
                stateSubject.send(.loading)
                models = try await api.games()
                if models.isEmpty {
                    stateSubject.send(.empty)
                } else {
                    let cellModels = models.map { $0.toGameCellModel() }
                    stateSubject.send(.value(cellModels))
                }
            } catch {
                stateSubject.send(.error)
            }
        }
    }
    
    private func select(row: Int) {
        let id = models[row].id
        onSelect(id)
    }

}

extension GamesViewModel: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if case let State.value(models) = stateSubject.value {
            return models.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard case let State.value(models) = stateSubject.value else {
            return UITableViewCell()
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: GameCell.identifier, for: indexPath) as! GameCell
        cell.update(with: models[indexPath.row])
        return cell
    }
}
