//
//  MainViewController.swift
//  Swappy
//
//  Created by Mihail on 17/03/2019.
//  Copyright © 2019 SwappyTeam. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    // MARK: - Constants
    
    private enum SegmentControlSection: Int {
        case
        catalog,
        myProducts
    }
    
    // MARK: - Properties
    
    @IBOutlet weak var catalogContainerView: UIView!
    @IBOutlet weak var myProductsContainerView: UIView!
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    weak var myProductsViewController: MyProductsViewController?
    weak var productCatalogViewController: ProductCatalogViewController?
    
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
        
        switch segue.destination {
        case let vc as MyProductsViewController:
            myProductsViewController = vc
        case let vc as ProductCatalogViewController:
            productCatalogViewController = vc
        default:
            break
        }
    }
    
    // MARK: - Actions
    
    @IBAction func segmentControlValueChanged(_ sender: UISegmentedControl) {
        let section = SegmentControlSection(rawValue: sender.selectedSegmentIndex) ?? .catalog
        switch section {
        case .catalog:
            catalogContainerView.isHidden = false
            myProductsContainerView.isHidden = true
            productCatalogViewController?.viewWillAppear(true)
            
        case .myProducts:
            catalogContainerView.isHidden = true
            myProductsContainerView.isHidden = false
            myProductsViewController?.viewWillAppear(true)
        }
    }
}
