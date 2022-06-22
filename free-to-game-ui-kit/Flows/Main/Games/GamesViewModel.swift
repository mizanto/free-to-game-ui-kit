//
//  GamesViewModel.swift
//  free-to-game-ui-kit
//
//  Created by Sergey Bendak on 22.06.2022.
//

import Combine

class GamesViewModel {
    private let api: API
    
    @Published var cellModels: [GameCellModel] = []
    
    private var models: [ShortGameModel] = [] {
        didSet { cellModels = models.map { $0.toGameCellModel() } }
    }
    
    init(api: API) {
        self.api = api
    }
    
    func viewDidLoad() {
        Task {
            let games = try await api.games()
            self.models = games
        }
    }
    
    func cellModel(for row: Int) -> GameCellModel {
        assert(row < cellModels.count)
        return cellModels[row]
    }
}
