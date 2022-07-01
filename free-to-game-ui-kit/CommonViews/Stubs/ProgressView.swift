//
//  ProgressView.swift
//  free-to-game-ui-kit
//
//  Created by Sergey Bendak on 23.06.2022.
//

import UIKit

final class ProgressView: UIView {
    private let activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    private let label: UILabel = UILabel.title(alignment: .center, numberOfLines: 0)
    let containerView: UIView = UIView()
    
    func setTitle(_ title: String) {
        label.text = title
    }
    
    func start() {
        activityIndicator.startAnimating()
    }
    
    func stop() {
        activityIndicator.stopAnimating()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        backgroundColor = .white
        
        addSubview(containerView)
        containerView.addSubviews(activityIndicator, label)
        
        containerView.snp.makeConstraints { make in
            make.centerX.equalTo(snp.centerX)
            make.centerY.equalTo(snp.centerY)
            make.width.equalToSuperview().multipliedBy(0.8)
        }
        
        activityIndicator.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        
        label.snp.makeConstraints { make in
            make.top.equalTo(activityIndicator.snp.bottom).offset(16)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}
