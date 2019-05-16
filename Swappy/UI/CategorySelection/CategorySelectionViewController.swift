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

class CategorySelectionViewController: CardViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var cardContainerView: UIView!
    
    var presenter: CategorySelectionPresenter!
    
    var cellModels: [CategoryCellViewModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        cardContainerView.roundCorners(corners: [.topLeft, .topRight], radius: 9)

        setupTableView()
        
        presenter.showCategories()
    }
    
    // MARK: - Actions
    
    @IBAction func saveButtonPressed(_ sender: MainButton) {
        presenter.saveSelectedCategory()
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func closePressed(_ sender: UIButton) {
        dismiss(animated: true)
    }
}

extension CategorySelectionViewController: CategorySelectionView {
    
    func displayCategories(_ categories: [CategoryCellViewModel]) {
        cellModels = categories
        tableView.reloadData()
        
        setupTableViewHeight()
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

