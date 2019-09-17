//
//  CategoriesViewController.swift
//  Swappy
//
//  Created by Mihail on 30/07/2019.
//  Copyright © 2019 SwappyTeam. All rights reserved.
//

import UIKit

protocol CategoriesView: AnyObject {
    
    func displayCells(_ cellModels: [CategoryCellViewModel])
}

final class CategoriesViewController: UIViewController {
    
    // MARK: - Properties
    
    var presenter: CategoriesPresenter!
    
    private var cellModels: [CategoryCellViewModel] = []
    
    @IBOutlet private weak var searchBar: UISearchBar!
    @IBOutlet private weak var tableView: UITableView!
    
    // MARK: - lifecycle Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        
        presenter.getCategories()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.isHidden = true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        if let searchResultsVC = segue.destination as? SearchResultsViewController {
            searchBar.delegate = searchResultsVC
        }
    }
}

// MARK: - CategoriesView protocol

extension CategoriesViewController: CategoriesView {
    
    func displayCells(_ cellModels: [CategoryCellViewModel]) {
        self.cellModels = cellModels
        
        tableView.reloadData()
    }
}

// MARK: - TableViewDataSource

extension CategoriesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CategoryTableViewCell = tableView.dequeueReusableCell()
        let model = cellModels[indexPath.row]
        
        cell.configure(with: model)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellModels.count
    }
}

// MARK: - TableViewDelegate

extension CategoriesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = cellModels[indexPath.row]
        let id = model.id
        
        presenter.showCategory(id: id)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - Private

private extension CategoriesViewController {
    
    func setupTableView() {
        tableView.register(cellType: CategoryTableViewCell.self)
        tableView.tableFooterView = UIView()
    }
}
