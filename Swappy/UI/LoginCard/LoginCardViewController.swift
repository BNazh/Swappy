//
//  LoginCardViewController.swift
//  Swappy
//
//  Created by Mihail on 14/03/2019.
//  Copyright © 2019 SwappyTeam. All rights reserved.
//

import UIKit

final class LoginCardViewController: CardViewController, ErrorView, LoadingView {
    
    @IBOutlet weak var cardContainerView: UIView!
    @IBOutlet weak var privacyTextView: UITextView!
    
    var vkService: VKService!
    var fbService: FBService!
    var authService: AuthService!
    var tracker: AnalyticsManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addSwipeGestureRecognizer()
        setupPrivacyTextView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        cardContainerView.roundCorners(corners: [.topRight, .topLeft], radius: 9)
    }
    
    @IBAction func vkButtonTapped(_ sender: UIButton) {
        tracker.track(event: .loginByVkClick)
        
        vkService.login(presentingHandler: vkPresentingHandler) { [weak self] result in
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    self?.handleVkServiceResponse(response)
                }
            case .failure(let error):
                self?.showError(message: error.localizedString)
            }
        }
    }
    @IBAction func fbButtonTapped(_ sender: FBButton) {
        tracker.track(event: .loginByFbClick)
        
        fbService.login(viewController: self, closure: authCompletionHandler)
    }
    
    @IBAction func phoneButtonTapped(_ sender: UIButton) {
        tracker.track(event: .loginByPhoneClick)
        
        let phoneLoginVC: PhoneLoginViewController = UIStoryboard.createViewController()
        phoneLoginVC.hidesBottomBarWhenPushed = true
        
        let navigationController = mainTabBarController?.profileNavigationController

        dismiss(animated: true) {
            navigationController?.pushViewController(phoneLoginVC, animated: true)
        }
    }
    
    func vkPresentingHandler(viewController: UIViewController) -> Void {
        present(viewController, animated: true)
    }
    
    @IBAction func close(_ sender: UIButton) {
        dismiss(animated: true)
    }
}

private extension LoginCardViewController {
    
    func handleVkServiceResponse(_ response: VKLoginResponse) {
        
        showLoading()
        authService.vkAuth(response: response, closure: authCompletionHandler)
    }
    
    func setupPrivacyTextView() {
        privacyTextView.attributedText = privacyString()
        
        privacyTextView.textColor = .manatee
        privacyTextView.linkTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.taupe
        ]
        
        privacyTextView.textAlignment = .center
        
        if #available(iOS 11.0, *) {
            privacyTextView.textDragInteraction?.isEnabled = false
        }
    }
    
    func privacyString() -> NSAttributedString {
        let linkText = "http://swappy.ru/privacyPolicy.html"
        let privacyText = "лицензионое соглашение\nи политику конфиденциальности"
        let text = "Продолжая пользоваться приложением,\nвы принимаете " + privacyText
        let attributedString = NSMutableAttributedString(string: text)
        
        attributedString.setAsLink(textToFind: privacyText, linkURL: linkText)
        return attributedString
    }
    
    func authCompletionHandler(result: Result<Void>) {
        hideLoading()
        
        switch result {
        case .success:
            dismiss(animated: true, completion: nil)
        case .failure(let error):
            showError(message: error.localizedString)
        }
    }
}

extension LoginCardViewController: AnalyticScreenProvider {
    var screen: AnalyticScreen {
        return .login
    }
}
