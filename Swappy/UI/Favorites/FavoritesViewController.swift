//
//  FavoritesViewController.swift
//  Swappy
//
//  Created by Mihail on 27/08/2019.
//  Copyright © 2019 SwappyTeam. All rights reserved.
//

import UIKit

protocol FavoritesView: ErrorView {
    
    func displayCells(_ cellModels: [ProductCellViewModel])
    func removeCell(with id: String)
}

class FavoritesViewController: UIViewController {
    
    // MARK: - Properties
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

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
    
    func showError(message: String) {
        (self as ErrorView).showError(message: message)
        
    }
}
