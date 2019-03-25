//
//  TipView.swift
//  Swappy
//
//  Created by Mihail on 25/03/2019.
//  Copyright © 2019 SwappyTeam. All rights reserved.
//

import UIKit
import MBProgressHUD

protocol TipView: class {
    
    func showTip(text: String, image: UIImage?)
}

extension TipView {
    
    func showTip(text: String) {
        showTip(text: text, image: nil)
    }
}

extension TipView where Self: UIViewController {
    
    func showTip(text: String, image: UIImage?) {
        let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
        
        hud.isSquare = true
        hud.label.text = text
        
        if let image = image {
            hud.customView = UIImageView(image: image)
        }
    
        hud.hide(animated: true, afterDelay: 2)
    }
}
