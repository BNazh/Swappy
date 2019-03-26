//
//  MyProductsViewController.swift
//  Swappy
//
//  Created by Mihail on 17/03/2019.
//  Copyright © 2019 SwappyTeam. All rights reserved.
//

import UIKit

protocol MyProductsView: class, ErrorView, LoadingView {
    
    func reloadProducts(_ products: [ProductCellViewModel])
}

final class MyProductsViewController: UIViewController {

    // MARK: - Properties
    
    var presenter: MyProductsPresenter!
    var dataDisplayManager: ProductsDDM!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataDisplayManager.setup(delegate: self, collectionView: collectionView)
        
        // presenter.loadMyProducts()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        presenter.loadMyProducts()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        switch segue.destination {
        case let containerVC as NoProductsViewController:
            
            containerVC.addProductTappedBlock = { [weak self] in
                self?.presenter.addProduct()
            }
        default:
            break
        }
    }
}

extension MyProductsViewController: MyProductsView {

    func reloadProducts(_ products: [ProductCellViewModel]) {
        dataDisplayManager.reloadProducts(products)
    }
}

extension MyProductsViewController: ProductsDDMDelegate {
    
    func didSelectProduct(withId id: String) {
        presenter.openProduct(withId: id)
    }
    
    func willDisplayLastCell() {
        presenter.loadMyProducts()
    }
    
    func refresh() {
        presenter.refreshMyProducts()
    }
}
