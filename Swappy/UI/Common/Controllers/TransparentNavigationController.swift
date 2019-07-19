//
//  TransparentNavigationController.swift
//  Swappy
//
//  Created by Mihail on 18/07/2019.
//  Copyright © 2019 SwappyTeam. All rights reserved.
//

import UIKit

final class TransparentNavigationController: UINavigationController {
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationBar.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
    }
    
    
}
