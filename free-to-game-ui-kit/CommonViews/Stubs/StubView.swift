//
//  StubView.swift
//  free-to-game-ui-kit
//
//  Created by Sergey Bendak on 23.06.2022.
//

import UIKit

class StubView: UIView {
    let container: UIView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLayout() {
        addSubview(container)
        container.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}
