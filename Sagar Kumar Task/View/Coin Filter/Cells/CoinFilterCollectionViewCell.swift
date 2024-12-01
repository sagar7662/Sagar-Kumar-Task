//
//  CoinFilterCollectionViewCell.swift
//  Sagar Kumar Task
//
//  Created by Sagar Kumar on 29/11/24.
//

import UIKit

class CoinFilterCollectionViewCell: UICollectionViewCell {
    
    static var identifier: String {
        return String(describing: self)
    }
    
    let filterLabel: UILabel = {
        let label = UILabel()
        label.font = CryptoFont.font(weight: .regular, size: 14)
        label.textColor = .black
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    @available(*, unavailable, message: "This cell cannot be instantiated from a storyboard or nib")
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.layer.cornerRadius = contentView.frame.height / 2
        contentView.layer.masksToBounds = true
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        filterLabel.text = nil
        contentView.backgroundColor = .clear
        filterLabel.textColor = .black
    }
    
    private func setupUI() {
        contentView.addSubview(filterLabel)
        
        NSLayoutConstraint.activate([
            filterLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            filterLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            filterLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            filterLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8)
        ])
    }
    
    func configure(_ filter: CoinFilter?) {
        guard let filter = filter else { return }
        contentView.backgroundColor = filter.isSelected ? .systemBlue : .white
        filterLabel.textColor = filter.isSelected ? .white : .systemBlue
        filterLabel.text = filter.title
    }
}
