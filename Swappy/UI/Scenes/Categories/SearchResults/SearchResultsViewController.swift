//
//  UISearchResultsController.swift
//  Swappy
//
//  Created by Mihail on 14/09/2019.
//  Copyright © 2019 SwappyTeam. All rights reserved.
//

import UIKit

protocol SearchResultsView: LoadingView {
    
    func displaySearchHistory(_ historyItems: [String])
    func displayProductCells(_ cellModels: [ProductCellViewModel])
}

class SearchResultsViewController: UIViewController {
    
    // MARK: - Properties
    
    var presenter: SearchResultsPresenter!
    var dataDisplayManager: ProductsDDM!
    
    private var historyItems: [String] = []
    
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var collectionView: UICollectionView!
    
    private weak var searchBar: UISearchBar?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(cellType: UITableViewCell.self)
        dataDisplayManager.setup(delegate: self, collectionView: collectionView)
        view.superview?.isHidden = true
    }
}

// MARK: - SearchResultsView

extension SearchResultsViewController: SearchResultsView {
    
    func displaySearchHistory(_ historyItems: [String]) {
        self.historyItems = historyItems
        tableView.reloadData()
        
        tableView.isHidden = false
        collectionView.isHidden = true
    }
    
    func displayProductCells(_ cellModels: [ProductCellViewModel]) {
        dataDisplayManager.reloadProducts(cellModels)
        
        tableView.isHidden = true
        collectionView.isHidden = false
    }
}

// MARK: - UISearchBarDelegate

extension SearchResultsViewController: UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.searchBar = searchBar
        
        if searchBar.text == "" {
            presenter.showSearchHistory()
        }
        
        view.superview?.isHidden = false
        
        searchBar.setShowsCancelButton(true, animated: true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == "" {
            presenter.showSearchHistory()
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
        
        guard let searchText = searchBar.text, !searchText.isEmpty else { return }
        presenter.showProducts(searchString: searchText)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        
        searchBar.endEditing(true)
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        if searchBar.text == "" {
            view.superview?.isHidden = true
        }
        
        searchBar.setShowsCancelButton(false, animated: true)
    }
}

// MARK: - UITableViewDataSource

extension SearchResultsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell()
        
        cell.textLabel?.text = historyItems[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return historyItems.count
    }
}

// MARK: - ProductsDDMDelegate

extension SearchResultsViewController: ProductsDDMDelegate {
    
    func didSelectProduct(withId id: String) {
        presenter.showProduct(with: id)
    }
    
    func refresh() {
        presenter.refreshProducts()
    }
}
