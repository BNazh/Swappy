//
//  CategoriesFilter.swift
//  Swappy
//
//  Created by Mihail on 12/05/2019.
//  Copyright © 2019 SwappyTeam. All rights reserved.
//

import UIKit

protocol CategoryFilterView: class {
    
    func displayCategories(_ cellModels: [CategoryCellViewModel])
}

final class CategoryFilterViewController: CardViewController {
    
    // MARK: - Properties
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var cardContainerView: UIView!
    
    var presenter: CategoryFilterPresenter!
    
    var cellModels: [CategoryCellViewModel] = []
    
    // MARK: - Functions Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cardContainerView.roundCorners(corners: [.topLeft, .topRight], radius: 9)
        setupTableView()
        
        presenter.showCategories()
    }
    
    // MARK: - Actions

    @IBAction func applyButtonPressed(_ sender: UIButton) {
        presenter.applyFilters()
        close()
    }
    
    @IBAction func close() {
        dismiss(animated: true, completion: nil)
    }
}

extension CategoryFilterViewController: CategoryFilterView {
    
    func displayCategories(_ cellModels: [CategoryCellViewModel]) {
        self.cellModels = cellModels
        setupTableViewHeight()
        tableView.reloadData()
    }
}

extension CategoryFilterViewController: UITableViewDataSource {
    
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

extension CategoryFilterViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let categoryId = cellModels[indexPath.row].id
        presenter.selectCategory(withId: categoryId)
        presenter.showCategories()
    }
}

private extension CategoryFilterViewController {
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.rowHeight = 40
        
        tableView.register(cellType: CategoryTableViewCell.self)
    }
    
    func setupTableViewHeight() {
        let cellsCount = CGFloat(cellModels.count)
        tableViewHeightConstraint.constant = cellsCount * tableView.rowHeight
        view.layoutIfNeeded()
    }
}
