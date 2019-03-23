//
//  LoginCardViewController.swift
//  Swappy
//
//  Created by Mihail on 14/03/2019.
//  Copyright © 2019 SwappyTeam. All rights reserved.
//

import UIKit

final class LoginCardViewController: CardViewController {
    
    @IBAction func phoneButtonTapped(_ sender: UIButton) {
        let phoneLoginVC: PhoneLoginViewController = UIStoryboard.createViewController()
        
        let navigationController = self.presentingViewController as? UINavigationController
        
        dismiss(animated: true) {
            navigationController?.pushViewController(phoneLoginVC, animated: true)
        }
    }
    
    @IBAction func close(_ sender: UIButton) {
        dismiss(animated: true)
    }
}
