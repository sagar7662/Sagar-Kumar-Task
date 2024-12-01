//
//  CoinTableViewCell.swift
//  Sagar Kumar Task
//
//  Created by Sagar Kumar on 28/11/24.
//

import UIKit

class CoinTableViewCell: UITableViewCell {
    
    static var identifier: String {
        return String(describing: self)
    }
    
    let coinImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let newImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = CryptoFont.font(weight: .regular, size: 16)
        label.textColor = .black
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let symbolLabel: UILabel = {
        let label = UILabel()
        label.font = CryptoFont.font(weight: .semiBold, size: 16)
        label.textColor = .black
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    @available(*, unavailable, message: "This cell cannot be instantiated from a storyboard or nib")
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        coinImageView.image = nil
        newImageView.image = nil
        nameLabel.text = nil
        symbolLabel.text = nil
    }
    
    private func setupUI() {
        selectionStyle = .none
        contentView.addSubview(newImageView)
        contentView.addSubview(coinImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(symbolLabel)
        
        let stackView = UIStackView(arrangedSubviews: [nameLabel, symbolLabel])
        stackView.axis = .vertical
        stackView.spacing = 4
        stackView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: coinImageView.leadingAnchor, constant: -8),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
            
            newImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            newImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
            newImageView.widthAnchor.constraint(equalToConstant: 30),
            newImageView.heightAnchor.constraint(equalTo: newImageView.widthAnchor, multiplier: 1),

            coinImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            coinImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            coinImageView.widthAnchor.constraint(equalToConstant: 40),
            coinImageView.heightAnchor.constraint(equalTo: coinImageView.widthAnchor, multiplier: 1)
        ])
    }
    
    func configure(_ coin: Coin?) {
        guard let coin = coin else { return }
        symbolLabel.text = coin.symbol
        if let status = coin.status {
            coinImageView.image = UIImage(named: status.imageName)
        }
        newImageView.image = coin.isNew ?? false ? .new : nil
        
        let coinName = coin.name ?? ""
        let isEnabled = coin.status != .inactive
        let fullText = isEnabled ? coinName : "\(coinName) \(String.disabled)"
        let attributedString = fullText.attributedString(withFont: CryptoFont.font(weight: .regular, size: 16),
                                                         color: .black,
                                                         substringStyles: [(substring: .disabled,
                                                                            font: CryptoFont.font(weight: .semiBold, size: 12),
                                                                            color: .red)])
        nameLabel.attributedText = attributedString
    }
}
