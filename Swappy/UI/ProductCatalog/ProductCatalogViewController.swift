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
}

final class ProductCatalogViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var presenter: ProductCatalogPresenter!
    var dataDisplayManager: ProductsDDM!
    
    // MARK: - Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        definesPresentationContext = true
        
        dataDisplayManager.setup(delegate: self, collectionView: collectionView)
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 4, bottom: 0, right: 4)
        
        presenter.loadProducts()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        dataDisplayManager.endRefreshing()
    }
    
    // MARK: - Actions
    
    @IBAction func filterButtonPressed(_ sender: UIButton) {
        
    }
    
}

extension ProductCatalogViewController: ProductCatalogView {
    
    func reloadCells(_ cellModels: [ProductCellViewModel]) {
        dataDisplayManager.reloadProducts(cellModels)
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
