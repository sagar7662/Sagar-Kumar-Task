//
//  CoinListViewController.swift
//  Sagar Kumar Task
//
//  Created by Sagar Kumar on 28/11/24.
//

import UIKit
import Combine

class CoinListViewController: BaseViewController {
    
    private let tableView = UITableView()
    private let searchBar = UISearchBar()
    private lazy var filterView: CoinFilterView = {
        let view = CoinFilterView(viewModel: CoinFilterViewModel(filters: viewModel.filters), delegate: self)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private lazy var noDataView: NoDataView = {
        let view = NoDataView()
        view.configure(with: .noCoinsAvailable)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let viewModel: CoinListViewModel
    private var cancellables = Set<AnyCancellable>()
    private lazy var isSearchActive = false
    private lazy var isFilterActive = false
    
    init(viewModel: CoinListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindViewModel()
        showLoading()
        viewModel.fetchCoins()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        setupNavigationBar()
        setupTableView()
    }
    
    private func setupNavigationBar() {
        setLeftNavBar(with: .coin.uppercased())
        setNavigationRightBarButton()
        
        searchBar.delegate = self
        searchBar.placeholder = .searchCoins
        searchBar.isHidden = true
        searchBar.customizeAppearance()
        navigationItem.titleView = searchBar
    }
    
    private func setNavigationRightBarButton() {
        if isSearchActive {
            navigationItem.rightBarButtonItems = [UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(didTapSearch))]
        } else {
            let search = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(didTapSearch))
            let filter = UIBarButtonItem(image: .filter, style: .plain, target: self, action: #selector(showFilter))
            navigationItem.rightBarButtonItems = [search, filter]
        }
    }
    
    private func setupTableView() {
        tableView.register(CoinTableViewCell.self, forCellReuseIdentifier: CoinTableViewCell.identifier)
        tableView.dataSource = self
        tableView.separatorInset = .zero
        tableView.keyboardDismissMode = .onDrag
        view.addSubview(tableView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    private func showFilterView() {
        guard !isFilterActive else { return }
        if filterView.superview == nil {
            view.addSubview(filterView)
            NSLayoutConstraint.activate([
                filterView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                filterView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                filterView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                filterView.heightAnchor.constraint(equalToConstant: 150)
            ])
        }
        UIView.animate(withDuration: 0.3, animations: {
            self.filterView.alpha = 1
            self.tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 150, right: 0)
        }) { _ in
            self.filterView.isHidden = false
            self.isFilterActive = true
        }
    }
    
    private func hideFilterView() {
        UIView.animate(withDuration: 0.3, animations: {
            self.filterView.alpha = 0
            self.tableView.contentInset = .zero
        }) { _ in
            self.filterView.isHidden = true
            self.isFilterActive = false
        }
    }
    
    private func showNoDataView() {
        if noDataView.superview == nil {
            view.addSubview(noDataView)
            NSLayoutConstraint.activate([
                noDataView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                noDataView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                noDataView.leadingAnchor.constraint(greaterThanOrEqualTo: view.leadingAnchor, constant: 16),
                noDataView.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -16)
            ])
        }
        noDataView.isHidden = false
    }
    
    private func hideNoDataView() {
        noDataView.isHidden = true
    }
    
    private func bindViewModel() {
        viewModel.$filteredCoins
            .dropFirst()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.updateUI()
            }
            .store(in: &cancellables)
        
        viewModel.$errorMessage
            .compactMap { $0 }
            .receive(on: DispatchQueue.main)
            .sink { [weak self] error in
                self?.showError(message: error)
            }
            .store(in: &cancellables)
    }
    
    private func updateUI() {
        hideLoading()
        let hasData = !viewModel.filteredCoins.isEmpty
        tableView.isHidden = !hasData
        hasData ? hideNoDataView() : showNoDataView()
        tableView.reloadData()
    }
    
    private func showError(message: String) {
        hideLoading()
        showAlert(message: message)
    }
    
    @objc private func didTapSearch() {
        if isSearchActive {
            searchBar.text = nil
            searchBar.isHidden = true
            searchBar.resignFirstResponder()
            isSearchActive = false
            viewModel.searchCoins()
        } else {
            searchBar.isHidden = false
            searchBar.becomeFirstResponder()
            isSearchActive = true
        }
        setNavigationRightBarButton()
    }
    
    @objc private func showFilter() {
        showFilterView()
    }
}

extension CoinListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.filteredCoins.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CoinTableViewCell.identifier, for: indexPath) as? CoinTableViewCell else { return UITableViewCell()
        }
        let coin = viewModel.filteredCoins[indexPath.row]
        cell.configure(coin)
        return cell
    }
}

extension CoinListViewController: UISearchBarDelegate {

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.searchCoins(with: searchText)
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        didTapSearch()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}

extension CoinListViewController: CoinFilterDelete {
    
    func didSelect(filter: CoinFilter, index: Int) {
        self.viewModel.update(filter: filter, index: index)
    }
    
    func close() {
        hideFilterView()
    }
}
