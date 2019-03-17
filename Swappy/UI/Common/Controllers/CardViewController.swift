//
//  CardViewController.swift
//  Swappy
//
//  Created by Mihail on 14/03/2019.
//  Copyright © 2019 SwappyTeam. All rights reserved.
//

import UIKit

class CardViewController: UIViewController {
    
    weak var shadeView: UIView?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        showShade()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeShade()
    }
    
    override func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
        
        
        super.dismiss(animated: flag, completion: completion)
    }
}

private extension CardViewController {
    
    func showShade() {
        self.shadeView?.removeFromSuperview()
        
        let parentView = presentingViewController?.view ?? UIView()
        let shadeView = UIView(frame: parentView.frame)
        shadeView.backgroundColor = .black
        shadeView.alpha = 0
        
        parentView.addSubview(shadeView)
        
        self.shadeView = shadeView
        
        UIView.animate(withDuration: 0.5, animations: {
            shadeView.alpha = 0.4
        })
    }
    
    func removeShade() {
        UIView.animate(withDuration: 0.5, animations: {
            self.shadeView?.alpha = 0
        }) { _ in
            self.shadeView?.removeFromSuperview()
        }
    }
}
