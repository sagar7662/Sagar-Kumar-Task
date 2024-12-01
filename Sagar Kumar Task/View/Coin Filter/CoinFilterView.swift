//
//  CoinFilterView.swift
//  Sagar Kumar Task
//
//  Created by Sagar Kumar on 29/11/24.
//

import UIKit

protocol CoinFilterDelete: AnyObject {
    func didSelect(filter: CoinFilter, index: Int)
    func close()
}

class CoinFilterView: UIView {

    private let collectionView: UICollectionView
    private let closeButton = UIButton()
    private let titleLabel = UILabel()
    private let viewModel: CoinFilterViewModel
    private weak var delegate: CoinFilterDelete?

    init(viewModel: CoinFilterViewModel, delegate: CoinFilterDelete?) {
        self.viewModel = viewModel
        self.delegate = delegate

        let layout = LeftAlignedFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)

        super.init(frame: .zero)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        self.backgroundColor = .secondarySystemBackground
        
        titleLabel.text = .selectFilters
        titleLabel.font = CryptoFont.font(weight: .semiBold, size: 16)
        titleLabel.textColor = .systemBlue
        addSubview(titleLabel)

        closeButton.setImage(UIImage(systemName: "xmark"), for: .normal)
        closeButton.addTarget(self, action: #selector(close(_:)), for: .touchUpInside)
        addSubview(closeButton)

        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(CoinFilterCollectionViewCell.self, forCellWithReuseIdentifier: CoinFilterCollectionViewCell.identifier)
        collectionView.backgroundColor = .clear
        collectionView.isScrollEnabled = false
        addSubview(collectionView)

        setupConstraints()
    }

    private func setupConstraints() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 12), 
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: closeButton.leadingAnchor, constant: -8),
            titleLabel.heightAnchor.constraint(equalToConstant: 30),
            
            closeButton.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            closeButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            closeButton.widthAnchor.constraint(equalToConstant: 30),
            closeButton.heightAnchor.constraint(equalTo: closeButton.widthAnchor),

            collectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)
        ])
    }

    @objc private func close(_ sender: UIButton) {
        delegate?.close()
    }
}

extension CoinFilterView: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.filters.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CoinFilterCollectionViewCell.identifier, for: indexPath) as? CoinFilterCollectionViewCell else {
            return UICollectionViewCell()
        }
        let filter = viewModel.filters[indexPath.item]
        cell.configure(filter)
        return cell
    }
}

extension CoinFilterView: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let filter = viewModel.filters[indexPath.item].title
        let width = filter.getMaxWidth(for: CryptoFont.font(weight: .regular, size: 14), height: 30)
        return CGSize(width: width + 20, height: 30)
    }
}

extension CoinFilterView: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.toggle(on: indexPath.item)
        UIView.performWithoutAnimation {
            collectionView.performBatchUpdates {
                collectionView.reloadItems(at: [indexPath])
            }
        }
        delegate?.didSelect(filter: viewModel.filters[indexPath.item], index: indexPath.item)
    }
}
