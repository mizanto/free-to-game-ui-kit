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
    private enum Constant {
        static let verticalPadding: CGFloat = 16
        static let horizontalPadding: CGFloat = 16
        static let buttonVerticalPadding: CGFloat = 12
    }
    
    var viewModel: GameInfoViewModel!
    
    private var scrollView: UIScrollView!
    private var infoView: GameInfoView!
    private var buttonContainer: ShadowView!
    private var actionButton: PrimaryButton!
    
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
        
        actionButton = PrimaryButton(title: viewModel.actionButtonTitle)
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
        
        bindToViewModel()
        viewModel.sendEvent(.fetchData)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupLayout()
    }
    
    private func setupLayout() {
        scrollView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
        }
        
        infoView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(Constant.horizontalPadding)
            make.top.equalToSuperview().offset(Constant.verticalPadding)
            make.right.equalToSuperview().offset(-Constant.horizontalPadding)
            make.bottom.equalToSuperview().offset(-Constant.verticalPadding)
            make.width.equalTo(scrollView.snp.width).offset(-2 * Constant.horizontalPadding)
        }
        
        buttonContainer.snp.makeConstraints { make in
            make.height.equalTo(PrimaryButton.height + 2 * Constant.buttonVerticalPadding + view.safeAreaInsets.bottom)
            make.top.equalTo(scrollView.snp.bottom)
            make.left.right.bottom.equalToSuperview()
        }

        actionButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(Constant.buttonVerticalPadding)
            make.left.equalToSuperview().offset(Constant.horizontalPadding)
            make.right.equalToSuperview().offset(-Constant.horizontalPadding)
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
            showInfoView(from: infoModel)
        case .loading(let message):
            showProgressView(title: message)
        case .error(let message):
            showStubView(type: .error, message: message, action: retry)
        }
    }
    
    private func showInfoView(from model: GameInfoModel) {
        hideAnyStubs()
        infoView.update(with: model)
    }
    
    private func retry() {
        viewModel.sendEvent(.retry)
    }
}
