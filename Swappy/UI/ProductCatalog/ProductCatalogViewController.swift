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
    func displayInitialize(headerModel: HeaderViewModel, isFilterButtonHidden: Bool)
}

final class ProductCatalogViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var filterButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    
    var presenter: ProductCatalogPresenter!
    var dataDisplayManager: ProductsDDM!
    
    // MARK: - Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        definesPresentationContext = true
        
        dataDisplayManager.setup(delegate: self, collectionView: collectionView)
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 8, bottom: 100, right: 8)
        
        presenter.initialize()
        presenter.loadProducts()
        
        setupNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        dataDisplayManager.endRefreshing()
    }
    
    // MARK: - Actions
    
    @IBAction func filterButtonPressed(_ sender: UIButton) {
        presenter.showCategoryFilter()
    }
    
    @IBAction func backButtonAction(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
}

extension ProductCatalogViewController: ProductCatalogView {
    
    func reloadCells(_ cellModels: [ProductCellViewModel]) {
        dataDisplayManager.reloadProducts(cellModels)
    }
    
    func setFilterButton(_ isFilterOn: Bool) {
        filterButton.isSelected = isFilterOn
    }
    
    func displayInitialize(headerModel: HeaderViewModel, isFilterButtonHidden: Bool) {
        dataDisplayManager.reloadHeader(headerModel)
        filterButton.isHidden = isFilterButtonHidden
        backButton.isHidden = !isFilterButtonHidden
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
    
    func setupNavigationBar() {
        
    }
}
