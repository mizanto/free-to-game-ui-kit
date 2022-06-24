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

final class GamesViewController: UIViewController {
    
    enum Intent {
        case fetchData
        case selectRow(Int)
    }
    
    var viewModel: GamesViewModel!
    
    private var tableView: UITableView = GamesViewController.createTableView()
    private var subscriptions = Set<AnyCancellable>()

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = viewModel
        tableView.delegate = self
        
        setupLayout()
        bindToViewModel()
        viewModel.sendEvent(.fetchData)
    }
    
    private func setupLayout() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.snp.edges)
        }
    }
    
    private func bindToViewModel() {
        viewModel.statePublisher
            .print("view")
            .receive(on: DispatchQueue.main)
            .sink { state in
                self.render(state: state)
            }
            .store(in: &subscriptions)
    }
    
    private func render(state: GamesViewModel.State) {
        switch state {
        case .empty:
            showInfoView(text: "No games")
        case .value(_):
            hideAnyStubs()
            tableView.reloadData()
        case .loading:
            showProgressView(title: "Trying to laod games...")
        case .error:
            showErrorView(message: "Something went wrong :c")
        }
    }
}

extension GamesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.sendEvent(.selectRow(indexPath.row))
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
