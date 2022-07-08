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
    var viewModel: GamesViewModelProtocol!
    
    private var tableView: UITableView!
    
    private var subscriptions = Set<AnyCancellable>()
    
    override func loadView() {
        super.loadView()
        
        tableView = UITableView()
        tableView.tableFooterView = UIView()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        tableView.register(GameCell.self, forCellReuseIdentifier: GameCell.identifier)
        tableView.dataSource = viewModel
        tableView.delegate = self
        
        view.addSubview(tableView)
        
        title = viewModel.title
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindToViewModel()
        viewModel.sendEvent(.fetchData)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupLayout()
    }
    
    private func setupLayout() {
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
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
    
    private func render(state: ViewState<[GameCellModel]>) {
        switch state {
        case .empty(let message):
            showInfoView(type: .empty, message: message, action: retry)
        case .content(_):
            hideAnyStubs()
            tableView.reloadData()
        case .loading(let title):
            showProgressView(title: title)
        case .error(let message):
            showInfoView(type: .error, message: message, action: retry)
        }
    }
    
    private func retry() {
        viewModel.sendEvent(.retry)
    }
}

extension GamesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.sendEvent(.selectRow(indexPath.row))
    }
}
