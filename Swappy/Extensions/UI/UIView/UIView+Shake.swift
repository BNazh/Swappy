//
//  UIView+Shake.swift
//  Swappy
//
//  Created by Mihail on 29/08/2019.
//  Copyright © 2019 SwappyTeam. All rights reserved.
//

import UIKit

extension UIView {
    
    func shake() {
        self.transform = CGAffineTransform(translationX: 20, y: 0)
        UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
            self.transform = CGAffineTransform.identity
        }, completion: nil)
    }
}
