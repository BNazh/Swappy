//
//  LoginCardViewController.swift
//  Swappy
//
//  Created by Mihail on 14/03/2019.
//  Copyright © 2019 SwappyTeam. All rights reserved.
//

import UIKit

final class LoginCardViewController: CardViewController {
    
    var tracker: AnalyticsManager!
    
    @IBAction func vkButtonTapped(_ sender: UIButton) {
        
    }
    
    @IBAction func phoneButtonTapped(_ sender: UIButton) {
        tracker.track(event: .loginByPhoneClick)
        
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

extension LoginCardViewController: AnalyticScreenProvider {
    var screen: AnalyticScreen {
        return .login
    }
}
