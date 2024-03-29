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
    func displayResetButton(isHidden: Bool)
}

final class CategoryFilterViewController: CardViewController {
    
    // MARK: - Properties
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var cardContainerView: UIView!
    @IBOutlet weak var resetButtonContainerView: UIView!
    private let pullToDismissHandler = PullToDismissHandler()
    
    var presenter: CategoryFilterPresenter!
    
    var cellModels: [CategoryCellViewModel] = []
    
    // MARK: - Functions Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cardContainerView.roundCorners(corners: [.topLeft, .topRight], radius: 9)
        setupPullToDismiss()
        addSwipeGestureRecognizer()
        setupTableView()
        
        presenter.showCategories()
    }
    
    // MARK: - Actions

    @IBAction func applyButtonPressed(_ sender: UIButton) {
        presenter.applyFilters()
        close()
    }
    
    @IBAction func resetButtonPressed(_ sender: UIButton) {
        presenter.reset()
        presenter.showCategories()
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
    
    func displayResetButton(isHidden: Bool) {
        guard resetButtonContainerView.isHidden != isHidden else {
            return
        }
        
        resetButtonContainerView.isHidden = isHidden
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
    
    func setupPullToDismiss() {
        pullToDismissHandler.setup(scrollView: tableView) { [weak self] in
            self?.close()
        }
    }
}
