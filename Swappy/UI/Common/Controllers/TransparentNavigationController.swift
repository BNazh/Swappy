//
//  TransparentNavigationController.swift
//  Swappy
//
//  Created by Mihail on 01/07/2019.
//  Copyright © 2019 SwappyTeam. All rights reserved.
//

import UIKit

final class TransparentNavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
//        navigationBar.setBackgroundImage(UIImage(), for: .default)
//        navigationBar.shadowImage = UIImage()
//        navigationBar.alpha = 0
//        navigationBar.isTranslucent = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //navigationBar.isHidden = false
    }
}
