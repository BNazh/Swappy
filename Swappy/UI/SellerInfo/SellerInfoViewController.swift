//
//  SellerInfoViewController.swift
//  Swappy
//
//  Created by Mihail on 13/03/2019.
//  Copyright © 2019 SwappyTeam. All rights reserved.
//

import UIKit

protocol SellerInfoView: class {
    func displaySeller(viewModel: SellerInfoViewModel)
}

final class SellerInfoViewController: UIViewController {
    
    @IBOutlet weak var contactButton: MainButton!
    @IBOutlet weak var copyButton: MainButton!
    
    
    var presenter: SellerInfoPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.showSeller()
    }
    
    // MARK: - Actions
    
    
    @IBAction func copyTapped(_ sender: UIButton) {
        
    }
    
    @IBAction func contactButtonTapped(_ sender: UIButton) {
        
    }
    
    @IBAction func closeTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
}

extension SellerInfoViewController: SellerInfoView {
    
    func displaySeller(viewModel: SellerInfoViewModel) {
        contactButton.setTitle(viewModel.phone, for: .normal)
    }
}
