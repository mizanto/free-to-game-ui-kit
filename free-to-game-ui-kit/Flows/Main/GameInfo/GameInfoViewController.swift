//
//  GameInfoViewController.swift
//  free-to-game-ui-kit
//
//  Created by Sergey Bendak on 24.06.2022.
//

import Combine
import Kingfisher
import UIKit

final class GameInfoViewController: UIViewController {
    var viewModel: GameInfoViewModel!
    
    private let scrollView: UIScrollView = UIScrollView(showsHorizontalIndicator: false)
    private let infoView: GameInfoView = GameInfoView()
    
    private var subscriptions = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
        bindToViewModel()
        viewModel.sendEvent(.fetchData)
    }
    
    private func setupLayout() {
        view.backgroundColor = .white
        
        view.addSubview(scrollView)
        scrollView.addSubview(infoView)
        
        scrollView.snp.makeConstraints { make in
            make.top.left.right.bottom.equalToSuperview()
        }
        infoView.snp.makeConstraints { make in
            make.top.left.equalToSuperview().offset(16)
            make.right.bottom.equalToSuperview().offset(-16)
            make.width.equalTo(scrollView.snp.width).offset(-32)
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
    
    private func render(state: GameInfo.State) {
        switch state {
        case .value(let infoModel):
            infoView.isHidden = false
            hideAnyStubs()
            showInfoView(from: infoModel)
        case .loading:
            infoView.isHidden = true
            showProgressView(title: "Trying to laod game info...")
        case .error:
            infoView.isHidden = true
            showErrorView(message: "Something went wrong :c")
        }
    }
    
    private func showInfoView(from model: GameInfoModel) {
        infoView.update(with: model)
    }
}
