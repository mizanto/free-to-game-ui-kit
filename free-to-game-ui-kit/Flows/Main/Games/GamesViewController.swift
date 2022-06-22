//
//  GamesViewController.swift
//  free-to-game-ui-kit
//
//  Created by Sergey Bendak on 21.06.2022.
//

import UIKit
import SnapKit
import Kingfisher

class GamesViewController: UIViewController {
    
    let api = API()
    
    private lazy var tableView: UITableView = {
        let tv = UITableView()
        tv.tableFooterView = UIView()
        tv.rowHeight = UITableView.automaticDimension
        tv.separatorStyle = .none
        tv.delegate = self
        tv.dataSource = self
        return tv
    }()
    
    var games: [ShortGameModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.snp.edges)
        }
        
        tableView.register(GameCell.self, forCellReuseIdentifier: "GameCell")
        
        loadGames()
    }
    
    private func loadGames() {
        Task {
            let games = try await api.games()
            self.games = games
            tableView.reloadData()
        }
    }

}

extension GamesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return games.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GameCell", for: indexPath) as! GameCell
        let game = games[indexPath.row]
        cell.thumbnailImageView.kf.setImage(with: game.thumbnail)
        cell.platformTagView.text = game.platform
        cell.genreTagView.text = game.genre
        cell.titleLabel.text = game.title
        cell.infoLabel.text = game.shortDescription
        return cell
    }
}
