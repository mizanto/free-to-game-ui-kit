//
//  GameInfoViewController.swift
//  free-to-game-ui-kit
//
//  Created by Sergey Bendak on 24.06.2022.
//

import Combine
import UIKit

final class GameInfoViewController: UIViewController {
    enum Intent {
        case fetchData
    }
    
    var viewModel: GameInfoViewModel!
    
    private var subscriptions = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
        bindToViewModel()
        viewModel.sendEvent(.fetchData)
    }
    
    private func setupLayout() {
        view.backgroundColor = .orange
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
    
    private func render(state: GameInfoViewModel.State) {
        switch state {
        case .value(_):
            hideAnyStubs()
            showInfoView()
        case .loading:
            showProgressView(title: "Trying to laod game info...")
        case .error:
            showErrorView(message: "Something went wrong :c")
        }
    }
    
    private func showInfoView() {
        
    }
}
