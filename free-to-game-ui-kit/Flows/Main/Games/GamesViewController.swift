//
//  GamesViewController.swift
//  free-to-game-ui-kit
//
//  Created by Sergey Bendak on 21.06.2022.
//

import Combine
import Kingfisher
import UIKit

final class GamesViewController: UIViewController {
    var viewModel: GamesViewModel!
    
    private var tableView: UITableView!
    
    private var subscriptions = Set<AnyCancellable>()
    
    override func loadView() {
        super.loadView()
        
        tableView = UITableView()
        tableView.tableFooterView = UIView()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        tableView.register(GameCell.self, forCellReuseIdentifier: GameCell.identifier)
        
        view = tableView
        
        title = viewModel.title
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = viewModel
        tableView.delegate = self
        
        bindToViewModel()
        viewModel.sendEvent(.fetchData)
    }
    
    private func bindToViewModel() {
        viewModel.statePublisher
            .print("view")
            .receive(on: DispatchQueue.main)
            .sink { [weak self] state in
                guard let self = self else { return }
                self.render(state: state)
            }
            .store(in: &subscriptions)
    }
    
    private func render(state: Games.State) {
        switch state {
        case .empty(let title):
            showInfoView(title: title)
        case .value(_):
            hideAnyStubs()
            tableView.reloadData()
        case .loading(let title):
            showProgressView(title: title)
        case .error(let message):
            showErrorView(message: message)
        }
    }
}

extension GamesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.sendEvent(.selectRow(indexPath.row))
    }
}
