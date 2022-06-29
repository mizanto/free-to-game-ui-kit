//
//  ErrorView.swift
//  free-to-game-ui-kit
//
//  Created by Sergey Bendak on 23.06.2022.
//

import UIKit

final class ErrorView: StubView {
    private let label: UILabel = UILabel()
    
    var errorMessage: String? {
        set { label.text = newValue }
        get { return label.text }
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
        backgroundColor = .white
        container.addSubviews(label)
        
        label.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
