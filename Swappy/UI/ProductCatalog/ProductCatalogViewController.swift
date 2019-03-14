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
    
    var cellModels = [ProductCellViewModel]()
    
    // MARK: - Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Swappy"
        
        definesPresentationContext = true
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        //collectionView.contentInset = UIEdgeInsets(top: 0, left: 9, bottom: 0, right: 9)
        
        collectionView.register(cellType: ProductCollectionViewCell.self)
        
        if let layout = collectionView?.collectionViewLayout as? PinterestLayout {
            layout.delegate = self
        }
        
        presenter.loadProducts()
    }
}

extension ProductCatalogViewController: ProductCatalogView {
    
    func reloadCells(_ cellModels: [ProductCellViewModel]) {
        self.cellModels.append(contentsOf: cellModels)
        
        collectionView.reloadData()
    }
    
    func showError(message: String) {
        print(message)
    }
}

extension ProductCatalogViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: ProductCollectionViewCell = collectionView.dequeueReusableCell(indexPath: indexPath)
        
        let model = cellModels[indexPath.row]
        cell.configure(with: model)
        
//        print("---")
//        print(model.title.string)
//        print("---")
    
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let isLastElement = indexPath.row == cellModels.count - 1
        
        if isLastElement {
            presenter.loadProducts()
        }
    }
}

extension ProductCatalogViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let id = cellModels[indexPath.row].id
        presenter.selectProduct(with: id)
    }
}

extension ProductCatalogViewController: PinterestLayoutDelegate {
    
    func collectionView(_ collectionView: UICollectionView, heightForCellAtIndexPath indexPath: IndexPath, withWidth width: CGFloat) -> CGFloat {
        let viewModel = cellModels[indexPath.row]
        return viewModel.cellHeight(withWidth: width)
    }
}
