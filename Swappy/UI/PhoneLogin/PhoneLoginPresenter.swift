//
//  PhoneLoginPresenter.swift
//  Swappy
//
//  Created by Mihail on 20/03/2019.
//  Copyright © 2019 SwappyTeam. All rights reserved.
//

protocol PhoneLoginPresenter {
    
    func isPhoneFilled(_ phone: String) -> Bool
    func sendVerificationCode(to phone: String)
}

final class PhoneLoginPresenterImp {
    
    unowned let view: PhoneLoginView
    let router: PhoneLoginRouter
    let authService: AuthService
    
    init(view: PhoneLoginView, router: PhoneLoginRouter, authService: AuthService) {
        self.view = view
        self.router = router
        self.authService = authService
    }
}

extension PhoneLoginPresenterImp: PhoneLoginPresenter {
    
    func isPhoneFilled(_ phone: String) -> Bool {
        return phone.count == 11
    }
    
    func sendVerificationCode(to phone: String) {
        view.showLoading()
        
        authService.requestSmsVerificationCode(for: phone) { [weak self] result in
            self?.view.hideLoading()
            
            switch result {
            case .success:
                self?.router.openCodeConfirmation(phone: phone)
                
            case .failure(let error):
                self?.view.showError(message: error.localizedString)
            }
        }
    }
}
