//
//  ShadingDelegate.swift
//  Swappy
//
//  Created by Mihail on 17/03/2019.
//  Copyright © 2019 SwappyTeam. All rights reserved.
//

import UIKit

protocol ShadingDelegate: class {
    
    var shadingView: UIView? { get }
}

extension ShadingDelegate {
    
    func setShading(_ enableShading: Bool, completion: ((Bool) -> Void)? = nil) {
        UIView.animate(withDuration: 0.5, animations: {
            self.shadingView?.alpha = enableShading ? 0.4 : 0
        }, completion: completion)
    }
}