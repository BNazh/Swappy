//
//  ProductsDDM.swift
//  Swappy
//
//  Created by Mihail on 17/03/2019.
//  Copyright © 2019 SwappyTeam. All rights reserved.
//

import UIKit

protocol ProductsDDMDelegate: class {
    
    // MARK: - Funcitons
    
    func willDisplayLastCell()
    func didSelectProduct(withId id: String)
    func refresh()
}

protocol ProductsDDM: class {
    
    // MARK: - Functions
    
    func reloadProducts(_ productsCellModels: [ProductCellViewModel])
    func setup(delegate: ProductsDDMDelegate, collectionView: UICollectionView)
}
