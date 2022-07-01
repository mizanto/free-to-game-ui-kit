//
//  ImageCarouselView.swift
//  free-to-game-ui-kit
//
//  Created by Sergey Bendak on 29.06.2022.
//

import Kingfisher
import UIKit

final class ImageCarouselView: UIView {
    var title: String? {
        set { titleLabel.text = newValue }
        get { return titleLabel.text }
    }
    
    private let titleLabel: UILabel = UILabel.head()
    private let scrollView: UIScrollView = UIScrollView(showsHorizontalIndicator: false)
    private let hStack: HStackView = HStackView(alignment: .center, spacing: 8)
    
    init(title: String) {
        super.init(frame: .zero)
        setupLayout()
        titleLabel.text = title
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        addSubviews(titleLabel, scrollView)
        scrollView.addSubview(hStack)
        
        titleLabel.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
        }
        
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.left.right.bottom.equalToSuperview()
        }
        hStack.snp.makeConstraints { make in
            make.top.left.right.bottom.equalToSuperview()
            make.height.equalTo(scrollView.snp.height)
        }
    }
    
    func setImages(_ images: [UIImage], itemSize: CGSize) {
        let imageViews = images.map { image -> UIImageView in
            let imageView = UIImageView(image: image)
            imageView.snp.makeConstraints { make in
                make.width.equalTo(itemSize.width)
                make.height.equalTo(itemSize.height)
            }
            return imageView
        }
        hStack.setViews(imageViews)
    }
    
    func setContentOf(urls: [URL], itemSize: CGSize) {
        let imageViews = urls.map { url -> UIImageView in
            let imageView = UIImageView()
            imageView.snp.makeConstraints { make in
                make.width.equalTo(itemSize.width)
                make.height.equalTo(itemSize.height)
            }
            imageView.kf.setImage(with: url)
            return imageView
        }
        hStack.setViews(imageViews)
    }
}
