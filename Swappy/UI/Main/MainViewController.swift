//
//  MainViewController.swift
//  Swappy
//
//  Created by Mihail on 17/03/2019.
//  Copyright © 2019 SwappyTeam. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    // MARK: - Properties
    
    @IBOutlet weak var catalogContainerView: UIView!
    @IBOutlet weak var myProductsContainerView: UIView!
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    // MARK: - Functions lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        segmentedControl.selectedSegmentIndex = 0
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    // MARK: - Actions
    
    @IBAction func segmentControlValueChanged(_ sender: UISegmentedControl) {
        let showAllProducts = sender.selectedSegmentIndex == 0
        catalogContainerView.isHidden = !showAllProducts
        myProductsContainerView.isHidden = showAllProducts
    }
}
