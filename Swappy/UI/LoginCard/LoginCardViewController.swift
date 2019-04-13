//
//  LoginCardViewController.swift
//  Swappy
//
//  Created by Mihail on 14/03/2019.
//  Copyright © 2019 SwappyTeam. All rights reserved.
//

import UIKit

final class LoginCardViewController: CardViewController, ErrorView, LoadingView {
    
    var vkService: VKService!
    var authService: AuthService!
    var tracker: AnalyticsManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func vkButtonTapped(_ sender: UIButton) {
        vkService.login { [weak self] result in
            switch result {
            case .success(let response):
                self?.handleVkServiceResponse(response)
            case .failure(let error):
                self?.showError(message: error.localizedString)
            }
        }
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

private extension LoginCardViewController {
    
    func handleVkServiceResponse(_ response: VKLoginResponse) {
        
        showLoading()
        authService.vkAuth(response: response, closure: { [weak self] result in
            self?.hideLoading()
            
            switch result {
            case .success:
                self?.dismiss(animated: true, completion: nil)
            case .failure(let error):
                self?.showError(message: error.localizedString)
            }
        })
    }
}

extension LoginCardViewController: AnalyticScreenProvider {
    var screen: AnalyticScreen {
        return .login
    }
}
