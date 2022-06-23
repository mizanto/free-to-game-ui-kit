//
//  GamesViewModel.swift
//  free-to-game-ui-kit
//
//  Created by Sergey Bendak on 22.06.2022.
//

import Combine
import UIKit

class GamesViewModel: NSObject {
    enum State {
        case value([GameCellModel])
        case empty
        case loading
        case error
    }
    
    private let api: API
    
    private var stateSubject: CurrentValueSubject<State, Never>
    
    var statePublisher: AnyPublisher<State, Never> {
        return stateSubject.eraseToAnyPublisher()
    }
    
    private var models: [ShortGameModel] = []
    
    init(api: API) {
        self.api = api
        self.stateSubject = CurrentValueSubject(.empty)
    }
    
    func viewDidLoad() {
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
