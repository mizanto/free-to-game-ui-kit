//
//  GameCell.swift
//  free-to-game-ui-kit
//
//  Created by Sergey Bendak on 21.06.2022.
//

import SnapKit
import UIKit

class GameCell: UITableViewCell {
    private enum Constant {
        static let outerHorizontalPading: CGFloat = 16
        static let outerVerticalPading: CGFloat = 8
        static let innerHorizontalPadding: CGFloat = 12
        static let innerVerticalPadding: CGFloat = 12
        static let imageHeight: CGFloat = 180
    }
    
    private let cardView: CardView = createCardView()
    private let thumbnailImageView: UIImageView = createThumbnailImageView()
    private let platformTagView: TagView = createPlatformTagView()
    private let genreTagView: TagView = createGenreTagView()
    private let titleLabel: UILabel = createTitleLabel()
    private let infoLabel: UILabel = createInfoLabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        setupLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(with model: GameCellModel) {
        thumbnailImageView.kf.setImage(with: model.thumbnailUrl)
        platformTagView.text = model.platform
        genreTagView.text = model.genre
        titleLabel.text = model.title
        infoLabel.text = model.info
    }
    
    private func setupLayout() {
        addSubview(cardView)
        cardView.contentView.addSubviews(
            thumbnailImageView,
            platformTagView,
            genreTagView,
            titleLabel,
            infoLabel
        )
        
        cardView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(Constant.outerVerticalPading)
            make.bottom.equalToSuperview().offset(-Constant.outerVerticalPading)
            make.left.equalToSuperview().offset(Constant.outerHorizontalPading)
            make.right.equalToSuperview().offset(-Constant.outerHorizontalPading)
        }
        
        thumbnailImageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalTo(Constant.imageHeight)
        }
        
        platformTagView.snp.makeConstraints { make in
            make.top.equalTo(thumbnailImageView.snp.bottom).offset(Constant.innerVerticalPadding)
            make.left.equalToSuperview().offset(Constant.innerHorizontalPadding)
        }
        
        genreTagView.snp.makeConstraints { make in
            make.left.equalTo(platformTagView.snp.right).offset(8)
            make.centerY.equalTo(platformTagView.snp.centerY)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(platformTagView.snp.bottom).offset(Constant.innerVerticalPadding)
            make.left.equalToSuperview().offset(Constant.innerHorizontalPadding)
            make.right.equalToSuperview().offset(-Constant.innerHorizontalPadding)
        }
        
        infoLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.left.equalToSuperview().offset(Constant.innerHorizontalPadding)
            make.right.equalToSuperview().offset(-Constant.innerHorizontalPadding)
            make.bottom.equalToSuperview().offset(-Constant.innerVerticalPadding)
        }
    }
}

private extension GameCell {
    static func createCardView() -> CardView {
        let сv = CardView()
        сv.backgroundColor = .white
        return сv
    }
    
    static func createThumbnailImageView() -> UIImageView {
        let iv = UIImageView()
        return iv
    }
    
    static func createPlatformTagView() -> TagView {
        let tv = TagView()
        tv.color = .systemGreen
        return tv
    }
    
    static func createGenreTagView() -> TagView {
        let tv = TagView()
        tv.color = .systemBlue
        return tv
    }
    
    static func createTitleLabel() -> UILabel {
        let l = UILabel()
        l.font = .systemFont(ofSize: 22, weight: .semibold)
        l.numberOfLines = 0
        return l
    }
    
    static func createInfoLabel() -> UILabel {
        let l = UILabel()
        l.font = .systemFont(ofSize: 13)
        l.numberOfLines = 0
        return l
    }
}
