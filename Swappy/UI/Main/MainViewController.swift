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
    
    weak var myProductsViewController: MyProductsViewController?
    
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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        for child in children {
            child.viewDidAppear(animated)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        if let myProductsVC = segue.destination as? MyProductsViewController {
            myProductsViewController = myProductsVC
        }
    }
    
    // MARK: - Actions
    
    @IBAction func segmentControlValueChanged(_ sender: UISegmentedControl) {
        let showAllProducts = sender.selectedSegmentIndex == 0
        catalogContainerView.isHidden = !showAllProducts
        myProductsContainerView.isHidden = showAllProducts
    }
}
