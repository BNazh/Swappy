//
//  Test.swift
//  Swappy
//
//  Created by Mihail on 03/07/2019.
//  Copyright © 2019 SwappyTeam. All rights reserved.
//

import UIKit

final class TestViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        
        view.backgroundColor = .red
    }
}
