//
//  AddProductViewController.swift
//  Swappy
//
//  Created by Mihail on 17/03/2019.
//  Copyright © 2019 SwappyTeam. All rights reserved.
//

import UIKit

protocol AddProductView: class {
    func showProduct(viewModel: ProductViewModel)
    
}

final class EditProductViewController: UIViewController {
    
    // MARK: - Properties
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Разместить товар"
    }
}
