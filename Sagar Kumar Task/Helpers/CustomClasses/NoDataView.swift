//
//  NoDataView.swift
//  Sagar Kumar Task
//
//  Created by Sagar Kumar on 30/11/24.
//

import Foundation
import UIKit

class NoDataView: UIView {
    
    private let messageLabel: UILabel = {
        let label = UILabel()
        label.text = "No Data Found"
        label.textColor = .black
        label.textAlignment = .center
        label.font = CryptoFont.font(weight: .semiBold, size: 18)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }

    private func setupUI() {
        backgroundColor = .clear
        addSubview(messageLabel)
        NSLayoutConstraint.activate([
            messageLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            messageLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            messageLabel.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor, constant: 16),
            messageLabel.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: -16)
        ])
    }

    func configure(with message: String) {
        messageLabel.text = message
    }
}
