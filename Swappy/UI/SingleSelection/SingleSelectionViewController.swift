//
//  SingleSelectionViewController.swift
//  Swappy
//
//  Created by Mihail on 12/05/2019.
//  Copyright © 2019 SwappyTeam. All rights reserved.
//

import UIKit

protocol SingleSelectionView: class {
    
    func displayInitialize(title: String, buttonTitle: String)
    func displayItems(_ categories: [SelectionItemViewModel])
}

class SingleSelectionViewController: CardViewController {
    
    // MARK: - Properties
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var cardContainerView: UIView!
    @IBOutlet weak var saveButton: MainButton!
    
    var presenter: SingleSelectionPresenter!
    
    var cellModels: [SelectionItemViewModel] = []
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        cardContainerView.roundCorners(corners: [.topLeft, .topRight], radius: 9)

        setupTableView()
        
        presenter.initialize()
        presenter.showItems()
    }
    
    // MARK: - Actions
    
    @IBAction func saveButtonPressed(_ sender: MainButton) {
        presenter.saveSelectedItem()
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func closePressed(_ sender: UIButton) {
        dismiss(animated: true)
    }
}

// MARK: - SingleSelectionView

extension SingleSelectionViewController: SingleSelectionView {
    
    func displayItems(_ items: [SelectionItemViewModel]) {
        cellModels = items
        tableView.reloadData()
        
        setupTableViewHeight()
    }
    
    func displayInitialize(title: String, buttonTitle: String) {
        titleLabel.text = title
        saveButton.setTitle(buttonTitle, for: .normal)
    }
}

// MARK: - UITableViewDataSource

extension SingleSelectionViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: SelectionItemTableViewCell = tableView.dequeueReusableCell()
        let viewModel = cellModels[indexPath.row]
        
        cell.setup(with: viewModel)
        
        return cell
    }
}

// MARK: - UITableViewDelegate

extension SingleSelectionViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.selectItem(at: indexPath.row)
        presenter.showItems()
    }
}

// MARK: - Private

private extension SingleSelectionViewController {
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.rowHeight = 40
        
        tableView.register(cellType: SelectionItemTableViewCell.self)
    }
    
    func setupTableViewHeight() {
        let cellsCount = CGFloat(cellModels.count)
        tableViewHeightConstraint.constant = cellsCount * tableView.rowHeight
        view.layoutIfNeeded()
    }
}

