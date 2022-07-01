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
    
    private let cardView: CardView = CardView()
    private let thumbnailImageView: UIImageView = UIImageView()
    private let platformTagView: TagView = TagView(color: .systemGreen)
    private let genreTagView: TagView = TagView(color: .systemBlue)
    private let titleLabel: UILabel = UILabel.head(numberOfLines: 0)
    private let infoLabel: UILabel = UILabel.body(numberOfLines: 0)
    
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
