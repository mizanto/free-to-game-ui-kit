//
//  GameInfoView.swift
//  free-to-game-ui-kit
//
//  Created by Sergey Bendak on 26.06.2022.
//

import UIKit
import Kingfisher

final class GameInfoView: CardView {
    private enum Constant {
        static let horizontalPadding: CGFloat = 12
        static let verticalPadding: CGFloat = 12
    }
    
    private let vStack: VStackView = VStackView(alignment: .leading, spacing: 12)
    private let tagsHStack: HStackView = HStackView(alignment: .leading, spacing: 8)
    
    private let thumbnailImageView: UIImageView = UIImageView()
    private let platformTagView: TagView = TagView(color: .systemGreen)
    private let genreTagView: TagView = TagView(color: .systemBlue)
    private let aboutTextLabel: UILabel = UILabel.body(numberOfLines: 0)
    private let requirementsView: TextInfoBlockView
    private let additionalInfoView: TextInfoBlockView
    private let screenshotsView: ImageCarouselView
    
    init(requirementsTitle: String, additionalInfoTitle: String, screenshotsTitle: String) {
        requirementsView = TextInfoBlockView(headerTitle: requirementsTitle)
        additionalInfoView = TextInfoBlockView(headerTitle: additionalInfoTitle)
        screenshotsView = ImageCarouselView(title: screenshotsTitle)
        super.init(frame: .zero)
    }
    
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
        
        if !model.additionalInfo.isEmpty {
            additionalInfoView.setTiteledInfos(infos: model.additionalInfo)
            vStack.addView(additionalInfoView)
        }
        
        if !model.screenshotsUrls.isEmpty {
            vStack.addView(screenshotsView)
            screenshotsView.snp.makeConstraints { make in
                make.width.equalTo(vStack.snp.width)
            }
            screenshotsView.setContentOf(urls: model.screenshotsUrls, itemSize: .init(width: 130, height: 80))
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
            make.top.equalTo(thumbnailImageView.snp.bottom).offset(Constant.verticalPadding)
            make.left.equalToSuperview().offset(Constant.horizontalPadding)
        }
        
        vStack.snp.makeConstraints { make in
            make.top.equalTo(tagsHStack.snp.bottom).offset(Constant.verticalPadding)
            make.left.equalToSuperview().offset(Constant.horizontalPadding)
            make.right.equalToSuperview().offset(-Constant.horizontalPadding)
            make.bottom.equalToSuperview().offset(-Constant.verticalPadding)
        }
    }
}
