//
//  TagView.swift
//  free-to-game-ui-kit
//
//  Created by Sergey Bendak on 22.06.2022.
//

import UIKit

class TagView: UIView {
    var text: String? {
        set { label.text = newValue }
        get { return label.text }
    }
    
    var color: UIColor? {
        set {
            backgroundColor = newValue?.withAlphaComponent(0.15)
            label.textColor = newValue
        }
        get { return label.textColor}
    }
    
    private let label: UILabel = {
        let l = UILabel()
        l.font = .systemFont(ofSize: 15, weight: .bold)
        return l
    }()
    
    convenience init(color: UIColor) {
        self.init(frame: .zero)
        self.color = color
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
        layer.cornerRadius = 4
        
        addSubview(label)
        label.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(4)
            make.bottom.equalToSuperview().offset(-4)
            make.left.equalToSuperview().offset(8)
            make.right.equalToSuperview().offset(-8)
        }
    }
}
