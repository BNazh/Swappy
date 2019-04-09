//
//  ProductsDDMImp.swift
//  Swappy
//
//  Created by Mihail on 17/03/2019.
//  Copyright © 2019 SwappyTeam. All rights reserved.
//

import UIKit

final class ProductsDDMImp: NSObject {
    
    private var cellModels: [ProductCellViewModel] = []
    
    private weak var delegate: ProductsDDMDelegate?
    private weak var collectionView: UICollectionView?
    
    private let refreshControl = UIRefreshControl()
    
    private var layout: PinterestLayout? {
        return collectionView?.collectionViewLayout as? PinterestLayout
    }
}

extension ProductsDDMImp: ProductsDDM {
    
    func setup(delegate: ProductsDDMDelegate, collectionView: UICollectionView) {
        self.delegate = delegate
        self.collectionView = collectionView
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        setupRefreshControl()
        
        collectionView.register(cellType: ProductCollectionViewCell.self)
        
        layout?.delegate = self
    }
    
    func reloadProducts(_ productsCellModels: [ProductCellViewModel]) {
        refreshControl.endRefreshing()
        
        cellModels = productsCellModels
        
        layout?.clearCache()
        collectionView?.reloadData()
    }
    
    func endRefreshing() {
        refreshControl.endRefreshing()
    }
}

extension ProductsDDMImp: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let id = cellModels[indexPath.row].id
        delegate?.didSelectProduct(withId: id)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let isLastElement = indexPath.row == cellModels.count - 1
        
        if isLastElement {
            delegate?.willDisplayLastCell()
        }
    }
}

extension ProductsDDMImp: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: ProductCollectionViewCell = collectionView.dequeueReusableCell(indexPath: indexPath)
        
        let model = cellModels[indexPath.row]
        cell.configure(with: model)
        
        return cell
    }
}

extension ProductsDDMImp: PinterestLayoutDelegate {
    
    func collectionView(_ collectionView: UICollectionView, heightForCellAtIndexPath indexPath: IndexPath, withWidth width: CGFloat) -> CGFloat {
        let viewModel = cellModels[indexPath.row]
        return viewModel.cellHeight(withWidth: width)
    }
}

private extension ProductsDDMImp {
    
    func setupRefreshControl() {
        refreshControl.addTarget(self, action: #selector(refreshAction), for: .valueChanged)

        collectionView?.refreshControl = refreshControl
    }
    
    @objc
    func refreshAction() {
        delegate?.refresh()
    }
}
