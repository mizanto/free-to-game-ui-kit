//
//  GamesViewController.swift
//  free-to-game-ui-kit
//
//  Created by Sergey Bendak on 21.06.2022.
//

import Combine
import Kingfisher
import SnapKit
import UIKit

class GamesViewController: UIViewController {
    
    var viewModel: GamesViewModel!
    
    private var tableView: UITableView = GamesViewController.createTableView()
    private var subscriptions = Set<AnyCancellable>()

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        setupLayout()
        bindToViewModel()
        viewModel.viewDidLoad()
    }
    
    private func setupLayout() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.snp.edges)
        }
    }
    
    private func bindToViewModel() {
        viewModel.$cellModels
            .receive(on: DispatchQueue.main)
            .sink { _ in
                self.tableView.reloadData()
            }
            .store(in: &subscriptions)
    }
}

extension GamesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.cellModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: GameCell.identifier, for: indexPath) as! GameCell
        cell.update(
            with: viewModel.cellModel(for: indexPath.row)
        )
        return cell
    }
}

private extension GamesViewController {
    static func createTableView() -> UITableView {
        let tv = UITableView()
        tv.tableFooterView = UIView()
        tv.rowHeight = UITableView.automaticDimension
        tv.separatorStyle = .none
        tv.register(GameCell.self, forCellReuseIdentifier: GameCell.identifier)
        return tv
    }
}
