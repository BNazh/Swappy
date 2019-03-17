//
//  CardViewController.swift
//  Swappy
//
//  Created by Mihail on 14/03/2019.
//  Copyright © 2019 SwappyTeam. All rights reserved.
//

import UIKit

class CardViewController: UIViewController {
    
    weak var shadingDelegate: ShadingDelegate?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        shadingDelegate?.setShading(true)
    }
    
    override func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
        shadingDelegate?.setShading(false)
        
        super.dismiss(animated: flag, completion: completion)
    }
}
