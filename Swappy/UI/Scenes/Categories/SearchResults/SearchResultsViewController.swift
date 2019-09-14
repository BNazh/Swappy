//
//  UISearchResultsController.swift
//  Swappy
//
//  Created by Mihail on 14/09/2019.
//  Copyright © 2019 SwappyTeam. All rights reserved.
//

import UIKit

class SearchResultsViewController: UIViewController {
    
    // MARK: - Properties
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
}

extension SearchResultsViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        
    }
}
