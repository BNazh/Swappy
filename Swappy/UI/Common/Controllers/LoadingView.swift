//
//  LoadingView.swift
//  Swappy
//
//  Created by Mihail on 20/03/2019.
//  Copyright © 2019 SwappyTeam. All rights reserved.
//

import UIKit

protocol LoadingView {
    
    func showLoading()
    func hideLoading()
}

extension LoadingView where Self: UIViewController {
    func showLoading() {
        print("START LOADING")
    }
    
    func hideLoading() {
        print("HIDE LOADING")
    }
}
