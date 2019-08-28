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
}

class FavoritesViewController: UIViewController {
    
    // MARK: - Properties
    
    @IBOutlet weak var collectionView: UICollectionView!

    var dataDisplayManager: ProductsDDM!
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        dataDisplayManager.setup(delegate: self, collectionView: collectionView)
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension FavoritesViewController: FavoritesView {
    
    func displayCells(_ cellModels: [ProductCellViewModel]) {
        
    }
    
    func removeCell(with id: String) {
        // TODO: Delete?
    }
}

extension FavoritesViewController: ProductsDDMDelegate {
    
    func didSelectProduct(withId id: String) {
        
    }
    
    func refresh() {
        
    }
}
