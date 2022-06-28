//
//  TextInfoBlockView.swift
//  free-to-game-ui-kit
//
//  Created by Sergey Bendak on 24.06.2022.
//

import UIKit

final class TextInfoBlockView: UIView {
    private let headerTitleLabel: UILabel = UILabel(font: .systemFont(ofSize: 22, weight: .semibold))
    private let vStack: UIStackView = VStackView(alignment: .leading, spacing: 8)
    
    convenience init(headerTitle: String) {
        self.init(frame: .zero)
        headerTitleLabel.text = headerTitle
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @discardableResult
    func setHeaderTitle(_ title: String) -> Self {
        headerTitleLabel.text = title
        return self
    }
    
    @discardableResult
    func add(titledInfo: TitledInfo) -> Self {
        let tiv = TitleInfoView()
        tiv.setTitledInfo(titledInfo)
        addInfoView(tiv)
        return self
    }
    
    @discardableResult
    func add(title: String, info: String?) -> Self {
        let tiv = TitleInfoView()
        tiv.setTitle(title, info: info)
        addInfoView(tiv)
        return self
    }
    
    func setInfoViews(_ views: [TitleInfoView]) {
        vStack.removeAllArrangedSubviews()
        vStack.addArrangedSubviews(views)
    }
    
    func setInfoView(_ view: TitleInfoView) {
        vStack.removeAllArrangedSubviews()
        vStack.addArrangedSubview(view)
    }
    
    func setTiteledInfos(infos: [TitledInfo]) {
        setInfoViews(
            infos.map { TitleInfoView(titledInfo: $0) }
        )
    }
    
    func addInfoView(_ view: TitleInfoView) {
        vStack.addArrangedSubview(view)
    }
    
    private func setupLayout() {
        addSubviews(headerTitleLabel, vStack)
        headerTitleLabel.snp.makeConstraints { make in
            make.left.top.right.equalToSuperview()
        }
        vStack.snp.makeConstraints { make in
            make.top.equalTo(headerTitleLabel.snp.bottom).offset(8)
            make.left.right.bottom.equalToSuperview()
        }
    }
}
