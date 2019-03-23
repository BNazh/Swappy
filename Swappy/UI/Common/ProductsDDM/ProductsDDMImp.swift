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
}

extension ProductsDDMImp: ProductsDDM {
    
    func reloadProducts(_ productsCellModels: [ProductCellViewModel]) {
        cellModels = productsCellModels
        
        collectionView?.isHidden = cellModels.isEmpty
        collectionView?.reloadData()
    }
    
    func setup(delegate: ProductsDDMDelegate, collectionView: UICollectionView) {
        self.delegate = delegate
        self.collectionView = collectionView
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.register(cellType: ProductCollectionViewCell.self)
        
        if let layout = collectionView.collectionViewLayout as? PinterestLayout {
            layout.delegate = self
        }
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
