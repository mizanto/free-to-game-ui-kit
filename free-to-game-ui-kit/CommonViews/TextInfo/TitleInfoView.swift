//
//  TextInfoView.swift
//  free-to-game-ui-kit
//
//  Created by Sergey Bendak on 24.06.2022.
//

import UIKit

typealias TitledInfo = (title: String, info: String?)

final class TitleInfoView: UIView {
    var separator: String = ":"
    
    private let titleLabel: UILabel = UILabel.accent(numberOfLines: 0)
    private let infoLabel: UILabel = UILabel.body(numberOfLines: 0)
    
    convenience init(titledInfo: TitledInfo) {
        self.init(frame: .zero)
        titleLabel.text = titledInfo.title
        infoLabel.text = titledInfo.info
    }
    
    convenience init(title: String, info: String? = nil) {
        self.init(frame: .zero)
        titleLabel.text = title
        infoLabel.text = info
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setTitle(_ title: String, info: String?) {
        titleLabel.text = title + separator
        infoLabel.text = info
    }
    
    func setTitledInfo(_ data: TitledInfo) {
        titleLabel.text = data.title + separator
        infoLabel.text = data.info
    }
    
    private func setupLayout() {
        addSubviews(titleLabel, infoLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.left.top.equalToSuperview()
        }
        
        infoLabel.snp.makeConstraints { make in
            make.left.equalTo(titleLabel.snp.right).offset(4)
            make.top.bottom.right.equalToSuperview()
        }
    }
}
