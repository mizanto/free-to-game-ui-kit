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

        tableView.dataSource = viewModel
        tableView.delegate = self
        
        setupLayout()
        bindToViewModel()
        viewModel.viewDidLoad()
        showProgressView()
    }
    
    private func setupLayout() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.snp.edges)
        }
    }
    
    private func bindToViewModel() {
        viewModel.statePublisher
            .receive(on: DispatchQueue.main)
            .sink { state in
                switch state {
                case .empty:
                    print("Empty")
                    self.showInfoView(text: "No games")
                case .value(let items):
                    print("Success: \(items.count) intems(s)")
                    self.hideAnyStubs()
                    self.tableView.reloadData()
                case .loading:
                    print("Loading")
                    self.showProgressView(title: "Trying to laod games...")
                case .error:
                    self.showErrorView(message: "Something went wrong :c")
                    print("Error")
                }
            }
            .store(in: &subscriptions)
    }
}

extension GamesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("did select at: \(indexPath.row)")
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
