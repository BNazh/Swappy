//
//  ProductCatalogViewController.swift
//  Swappy
//
//  Created by Бабаев Михаил Михайлович on 07/03/2019.
//  Copyright © 2019 SwappyTeam. All rights reserved.
//

import UIKit

protocol ProductCatalogView: class, ErrorView {
    
    func reloadCells(_ cellModels: [ProductCellViewModel])
    func setFilterButton(_ isFilterOn: Bool)
}

final class ProductCatalogViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var filterButton: UIButton!
    
    var presenter: ProductCatalogPresenter!
    var dataDisplayManager: ProductsDDM!
    
    // MARK: - Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        definesPresentationContext = true
        
        dataDisplayManager.setup(delegate: self, collectionView: collectionView)
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 8, bottom: 100, right: 8)
        
        presenter.loadProducts()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        dataDisplayManager.endRefreshing()
    }
    
    // MARK: - Actions
    
    @IBAction func filterButtonPressed(_ sender: UIButton) {
        presenter.showCategoryFilter()
    }
}

extension ProductCatalogViewController: ProductCatalogView {
    
    func reloadCells(_ cellModels: [ProductCellViewModel]) {
        dataDisplayManager.reloadProducts(cellModels)
    }
    
    func setFilterButton(_ isFilterOn: Bool) {
        filterButton.isSelected = isFilterOn
    }
}

extension ProductCatalogViewController: ProductsDDMDelegate {
    
    func willDisplayLastCell() {
        presenter.loadProducts()
    }
    
    func didSelectProduct(withId id: String) {
        presenter.selectProduct(with: id)
    }
    
    func refresh() {
        presenter.refreshProducts()
    }
}

extension ProductCatalogViewController: AnalyticScreenProvider {
    
    var screen: AnalyticScreen {
        return .productCatalog
    }
}

private extension ProductCatalogViewController {
    
}
