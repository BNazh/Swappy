//
//  PhotosView.swift
//  Swappy
//
//  Created by Mihail on 23/03/2019.
//  Copyright © 2019 SwappyTeam. All rights reserved.
//

import UIKit

protocol PhotosView {
    
}

final class PhotosViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var cells = [UIImage]()
}

extension PhotosViewController: UICollectionViewDataSource {
    
    
}
