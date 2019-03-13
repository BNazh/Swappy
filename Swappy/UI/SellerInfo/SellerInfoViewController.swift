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
    
    @IBOutlet weak var contactButton: SecondaryButton!
    @IBOutlet weak var copyButton: MainButton!
    
    @IBOutlet weak var sellerContainer: UIView!
    
    var presenter: SellerInfoPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.showSeller()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        sellerContainer.roundCorners(corners: [.topLeft, .topRight], radius: 9)
    }
    
    // MARK: - Actions
    
    
    @IBAction func copyTapped(_ sender: UIButton) {
        let url = URL(string: "whatsapp://send?text=Hello%2Cfrom%20Swappy!")!
        let items = [url]
        let ac = UIActivityViewController(activityItems: items, applicationActivities: nil)
        present(ac, animated: true)
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
