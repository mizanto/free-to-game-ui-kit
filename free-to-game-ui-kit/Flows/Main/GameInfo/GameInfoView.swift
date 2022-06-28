//
//  GameInfoView.swift
//  free-to-game-ui-kit
//
//  Created by Sergey Bendak on 26.06.2022.
//

import UIKit

final class GameInfoView: CardView {
    private let vStack: VStackView = VStackView(alignment: .leading, spacing: 12)
    private let tagsHStack: HStackView = HStackView(alignment: .leading, spacing: 8)
    
    private let thumbnailImageView: UIImageView = UIImageView()
    private let platformTagView: TagView = TagView(color: .systemGreen)
    private let genreTagView: TagView = TagView(color: .systemBlue)
    private let requirementsView: TextInfoBlockView = TextInfoBlockView(headerTitle: "System Requirements")
    private let aboutTextLabel: UILabel = UILabel(font: .systemFont(ofSize: 15, weight: .regular), numberOfLines: 0)
    private let additionalnfoView: TextInfoBlockView = TextInfoBlockView(headerTitle: "Additional Information")
    
    func update(with model: GameInfoModel) {
        thumbnailImageView.kf.setImage(with: model.thumbnailUrl)
        platformTagView.text = model.platform
        genreTagView.text = model.genre
        
        vStack.removeAllArrangedSubviews()
        
        if !model.aboutText.isEmpty {
            aboutTextLabel.text = model.aboutText
            vStack.addView(aboutTextLabel)
        }
        
        if !model.requirements.isEmpty {
            requirementsView.setTiteledInfos(infos: model.requirements)
            vStack.addView(requirementsView)
        }
        
        if !model.additionInfo.isEmpty {
            additionalnfoView.setTiteledInfos(infos: model.additionInfo)
            vStack.addView(additionalnfoView)
        }
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        contentView.addSubviews(
            thumbnailImageView,
            tagsHStack,
            vStack
        )
        
        tagsHStack.setViews(platformTagView, genreTagView)
        
        thumbnailImageView.snp.makeConstraints { make in
            make.left.top.right.equalToSuperview()
        }
        
        tagsHStack.snp.makeConstraints { make in
            make.top.equalTo(thumbnailImageView.snp.bottom).offset(16)
            make.left.equalToSuperview().offset(12)
        }
        
        vStack.snp.makeConstraints { make in
            make.top.equalTo(tagsHStack.snp.bottom).offset(16)
            make.left.equalToSuperview().offset(12)
            make.right.equalToSuperview().offset(-12)
            make.bottom.equalToSuperview().offset(-12)
        }
    }
}
