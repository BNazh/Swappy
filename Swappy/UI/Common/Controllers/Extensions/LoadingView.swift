//
//  LoadingView.swift
//  Swappy
//
//  Created by Mihail on 20/03/2019.
//  Copyright © 2019 SwappyTeam. All rights reserved.
//

import UIKit
import MBProgressHUD

protocol LoadingView {
    
    func showLoading()
    func hideLoading()
}

extension LoadingView where Self: UIViewController {
    func showLoading() {
        let hud = MBProgressHUD.showAdded(to: view, animated: true)
        hud.mode = .indeterminate
    }
    
    func hideLoading() {
        MBProgressHUD.hide(for: view, animated: true)
    }
}
