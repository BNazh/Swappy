//
//  StartViewController.swift
//  Swappy
//
//  Created by Mihail on 22/05/2019.
//  Copyright © 2019 SwappyTeam. All rights reserved.
//

import UIKit

protocol StartView: class {
    func stopLoading()
    func showError()
}

final class StartViewController: UIViewController {
    
    // MARK: - Properties
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    

    // MARK: - Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityIndicator.startAnimating()
    }
}
