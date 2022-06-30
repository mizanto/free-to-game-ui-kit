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
    private let buttonContainer: ShadowView = ShadowView(shadowOffset: CGSize(width: 0, height: 4), shadowRadius: 16, shadowOpacity: 0.25)
    private let playNowButton: UIButton = RoundedButton(title: "Play now!", backgroundColor: UIColor(hex: "#5D5FEF")!, cornerRadius: 8)
    
    private var subscriptions = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
        bindToViewModel()
        
        playNowButton.addTarget(self, action: #selector(onPlayNowButtonPress(sender:)), for: .touchUpInside)
        
        viewModel.sendEvent(.fetchData)
    }
    
    private func setupLayout() {
        view.backgroundColor = .white
        buttonContainer.backgroundColor = .white
        
        view.addSubviews(scrollView, buttonContainer)
        scrollView.addSubview(infoView)
        
        buttonContainer.addSubview(playNowButton)
        
        scrollView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
        }
        infoView.snp.makeConstraints { make in
            make.top.left.equalToSuperview().offset(16)
            make.right.bottom.equalToSuperview().offset(-16)
            make.width.equalTo(scrollView.snp.width).offset(-32)
        }
        buttonContainer.snp.makeConstraints { make in
            make.height.equalTo(84)
            make.top.equalTo(scrollView.snp.bottom)
            make.left.right.bottom.equalToSuperview()
        }
        playNowButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(12)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.height.equalTo(48)
        }
    }
    
    @objc
    func onPlayNowButtonPress(sender: UIButton?) {
        viewModel.sendEvent(.playNowPressed)
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
