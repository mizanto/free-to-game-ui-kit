//
//  InfoView.swift
//  free-to-game-ui-kit
//
//  Created by Sergey Bendak on 23.06.2022.
//

import UIKit

final class InfoView: UIView {
    
    enum StubType {
        case error
        case empty
        
        var image: UIImage {
            switch self {
            case .error:
                return UIImage(named: "error-color")!
            case .empty:
                return UIImage(named: "no-results-color")!
            }
        }
    }
    
    private let imageView: UIImageView
    private let messageLabel: UILabel
    private let button: PrimaryButton
    private let container: UIView
    
    private let action: () -> ()
    
    init(type: StubType, message: String, buttonTitle: String, action: @escaping () -> ()) {
        self.imageView = UIImageView(image: type.image)
        self.messageLabel = UILabel.title(text: message, alignment: .center, numberOfLines: 0)
        self.button = PrimaryButton(title: buttonTitle)
        self.action = action
        self.container = UIView()
        
        super.init(frame: .zero)
        
        backgroundColor = .white
        button.addTarget(self, action: #selector(onButtonPress(sender:)), for: .touchUpInside)
        setupLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        addSubviews(container, button)
        container.addSubviews(imageView, messageLabel)
        
        container.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.8)
        }
        
        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.width.height.equalTo(128)
        }
        
        messageLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(64)
            make.left.right.bottom.equalToSuperview()
        }
        
        button.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).offset(-16)
        }
    }
    
    @objc
    private func onButtonPress(sender: UIButton?) {
        action()
    }
}
