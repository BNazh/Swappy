//
//  FavoritesViewController.swift
//  Swappy
//
//  Created by Mihail on 27/08/2019.
//  Copyright © 2019 SwappyTeam. All rights reserved.
//

import UIKit

protocol FavoritesView: AnyObject, ErrorView {
    
    func displayCells(_ cellModels: [ProductCellViewModel])
    func removeCell(with id: String)
    func endRefreshing()
}

class FavoritesViewController: UIViewController {
    
    // MARK: - Properties
    
    @IBOutlet weak var collectionView: UICollectionView!

    var dataDisplayManager: ProductsDDM!
    var presenter: FavoritesPresenter!
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        dataDisplayManager.setup(delegate: self, collectionView: collectionView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        presenter.refreshFavorites()
    }
    
}

extension FavoritesViewController: FavoritesView {
    
    func displayCells(_ cellModels: [ProductCellViewModel]) {
        dataDisplayManager.reloadProducts(cellModels)
    }
    
    func removeCell(with id: String) {
        // TODO: Delete?
    }
    
    func endRefreshing() {
        dataDisplayManager.endRefreshing()
    }
}

extension FavoritesViewController: ProductsDDMDelegate {
    
    func didSelectProduct(withId id: String) {
        presenter.openProduct(with: id)
    }
    
    func refresh() {
        presenter.refreshFavorites()
    }
}
