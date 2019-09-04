//
//  ProductsDDM.swift
//  Swappy
//
//  Created by Mihail on 17/03/2019.
//  Copyright © 2019 SwappyTeam. All rights reserved.
//

import UIKit

@objc
protocol ProductsDDMDelegate: AnyObject {
    
    // MARK: - Funcitons
    
    func didSelectProduct(withId id: String)
    func refresh()
    
    @objc optional func willDisplayLastCell()
    @objc optional func didPressedHeaderImage()
    @objc optional func didPressedAddProductButton()
}

protocol ProductsDDM: AnyObject {
    
    // MARK: - Functions
    
    func reloadProducts(_ productsCellModels: [ProductCellViewModel])
    func reloadHeader(_ headerModel: HeaderViewModel)
    func setup(delegate: ProductsDDMDelegate, collectionView: UICollectionView)
    func endRefreshing()
}

extension ProductsDDM {
}
