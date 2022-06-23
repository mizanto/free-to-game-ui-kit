//
//  ProgressView.swift
//  free-to-game-ui-kit
//
//  Created by Sergey Bendak on 23.06.2022.
//

import UIKit

final class ProgressView: StubView {
    private let activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    private let label: UILabel = UILabel()
    
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
    
    override func setupLayout() {
        super.setupLayout()
        container.addSubviews(activityIndicator, label)
        
        activityIndicator.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        
        label.snp.makeConstraints { make in
            make.top.equalTo(activityIndicator.snp.bottom).offset(8)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}
