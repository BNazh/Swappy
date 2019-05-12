//
//  CategorySelectionViewController.swift
//  Swappy
//
//  Created by Mihail on 12/05/2019.
//  Copyright © 2019 SwappyTeam. All rights reserved.
//

import UIKit

protocol CategorySelectionView: class {
    
    func displayCategories(_ categories: [CategoryCellViewModel])
}

class CategorySelectionViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var presenter: CategorySelectionPresenter!
    
    var cellModels: [CategoryCellViewModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(cellType: CategoryTableViewCell.self)
    }
    
    // MARK: - Actions
    
    @IBAction func saveButtonPressed(_ sender: MainButton) {
        presenter.saveSelectedCategory()
    }
}

extension CategorySelectionViewController: CategorySelectionView {
    
    func displayCategories(_ categories: [CategoryCellViewModel]) {
        cellModels = categories
        tableView.reloadData()
    }
}

extension CategorySelectionViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CategoryTableViewCell = tableView.dequeueReusableCell()
        let viewModel = cellModels[indexPath.row]
        
        cell.setup(with: viewModel)
        
        return cell
    }
}

extension CategorySelectionViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.selectCategory(at: indexPath.row)
        presenter.showCategories()
    }
}

private extension CategorySelectionViewController {
    
    
}

