//
//  NoProductsViewController.swift
//  Swappy
//
//  Created by Mihail on 17/03/2019.
//  Copyright © 2019 SwappyTeam. All rights reserved.
//

import UIKit

final class NoProductsViewController: UIViewController {
    
    var addProductTappedBlock: (() -> Void)?
    
    @IBAction func addProductTapped(_ sender: UIButton) {
        addProductTappedBlock?()
    }
}
