//
//  UICollectionView+RegisterCells.swift
//  Swappy
//
//  Created by Бабаев Михаил Михайлович on 07/03/2019.
//  Copyright © 2019 SwappyTeam. All rights reserved.
//

import UIKit

extension UICollectionView {
    
    // MARK: - Functions
    
    func dequeueReusableCell<T: UICollectionViewCell>(indexPath: IndexPath) -> T {
        var result: T
        if let cell = self.dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier, for: indexPath) as? T {
            result = cell
        } else {
            result = T()
        }
        return result
    }
    
    func register<T: UICollectionViewCell>(cellType: T.Type) {
        self.register(UINib(nibName: T.nibName, bundle: nil), forCellWithReuseIdentifier: T.reuseIdentifier)
    }
    
}
