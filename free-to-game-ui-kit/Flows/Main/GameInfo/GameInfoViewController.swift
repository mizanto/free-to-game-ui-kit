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
    
    private var scrollView: UIScrollView!
    private var infoView: GameInfoView!
    private var buttonContainer: ShadowView!
    private var actionButton: UIButton!
    
    private var subscriptions = Set<AnyCancellable>()
    
    override func loadView() {
        super.loadView()
        scrollView = UIScrollView(showsHorizontalIndicator: false)
        
        infoView = GameInfoView(
            requirementsTitle: viewModel.requirementsTitle,
            additionalInfoTitle: viewModel.additionalInfoTitle,
            screenshotsTitle: viewModel.screenshotsTitle
        )
        
        buttonContainer = ShadowView(
            shadowOffset: CGSize(width: 0, height: 4),
            shadowRadius: 16,
            shadowOpacity: 0.25
        )
        
        actionButton = RoundedButton(
            title: viewModel.actionButtonTitle,
            backgroundColor: UIColor(hex: "#5D5FEF")!,
            cornerRadius: 8
        )
        actionButton.addTarget(self, action: #selector(onPlayNowButtonPress(sender:)), for: .touchUpInside)
        
        view.addSubviews(scrollView, buttonContainer)
        scrollView.addSubview(infoView)
        buttonContainer.addSubview(actionButton)
        
        view.backgroundColor = .white
        buttonContainer.backgroundColor = .white
        title = viewModel.title
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
        bindToViewModel()
        viewModel.sendEvent(.fetchData)
    }
    
    private func setupLayout() {
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
        
        actionButton.snp.makeConstraints { make in
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
