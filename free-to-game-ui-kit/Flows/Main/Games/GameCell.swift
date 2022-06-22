//
//  GameCell.swift
//  free-to-game-ui-kit
//
//  Created by Sergey Bendak on 21.06.2022.
//

import UIKit
import SnapKit

class GameCell: UITableViewCell {
    let thumbnailImageView: UIImageView = createThumbnailImageView()
    let platformTagView: TagView = createPlatformTagView()
    let genreTagView: TagView = createGenreTagView()
    let titleLabel: UILabel = createTitleLabel()
    let infoLabel: UILabel = createInfoLabel()
    
    private let cardView: CardView = {
        let сv = CardView()
        сv.backgroundColor = .white
        return сv
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        setupLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
            make.top.equalToSuperview().offset(8)
            make.bottom.equalToSuperview().offset(-8)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
        }
        
        thumbnailImageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalTo(194)
        }
        
        platformTagView.snp.makeConstraints { make in
            make.top.equalTo(thumbnailImageView.snp.bottom).offset(16)
            make.left.equalToSuperview().offset(12)
        }
        
        genreTagView.snp.makeConstraints { make in
            make.left.equalTo(platformTagView.snp.right).offset(16)
            make.centerY.equalTo(platformTagView.snp.centerY)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(platformTagView.snp.bottom).offset(12)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
        }
        
        infoLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview().offset(-16)
        }
    }
}

private extension GameCell {
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
//        var font = UIFont.systemFont(ofSize: 13)
//        var ps = NSMutableParagraphStyle()
//        ps.maximumLineHeight = 4
//        ps.minimumLineHeight = 4
        let l = UILabel()
        l.font = .systemFont(ofSize: 13)
        l.numberOfLines = 0
        return l
    }
}
