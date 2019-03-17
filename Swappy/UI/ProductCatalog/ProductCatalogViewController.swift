//
//  ProductCatalogViewController.swift
//  Swappy
//
//  Created by Бабаев Михаил Михайлович on 07/03/2019.
//  Copyright © 2019 SwappyTeam. All rights reserved.
//

import UIKit

protocol ProductCatalogView: class {
    
    func reloadCells(_ cellModels: [ProductCellViewModel])
    func showError(message: String)
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
        
        presenter.loadProducts()
    }
}

extension ProductCatalogViewController: ProductCatalogView {
    
    func reloadCells(_ cellModels: [ProductCellViewModel]) {
        dataDisplayManager.appendProducts(cellModels)
    }
    
    func showError(message: String) {
        print(message)
    }
}

extension ProductCatalogViewController: ProductsDDMDelegate {
    
    func willDisplayLastCell() {
        presenter.loadProducts()
    }
    
    func didSelectProduct(withId id: String) {
        presenter.selectProduct(with: id)
    }
}
