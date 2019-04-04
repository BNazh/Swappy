//
//  CodeConfirmationPresenter.swift
//  Swappy
//
//  Created by Mihail on 21/03/2019.
//  Copyright © 2019 SwappyTeam. All rights reserved.
//

import Foundation

protocol CodeConfirmationPresenter: class {
    
    func setPhone(_ phone: String)
    
    func authenticate(with code: String)
    func showInfo()
    func getNewConfirmationCode()
}

final class CodeConfirmationPresenterImp {
    
    private unowned let view: CodeConfirmationView
    private let authService: AuthService
    private let tracker: AnalyticsManager
    
    private var phone: String = ""
    
    init(view: CodeConfirmationView, authService: AuthService, tracker: AnalyticsManager) {
        self.view = view
        self.authService = authService
        self.tracker = tracker
    }
}


extension CodeConfirmationPresenterImp: CodeConfirmationPresenter {
    
    func setPhone(_ phone: String) {
        self.phone = phone
    }
    
    func authenticate(with code: String) {
        view.showLoading()
        
        authService.authenticate(phone: phone, code: code) { [weak self] result in
            self?.view.hideLoading()
            
            switch result {
            case .success:
                self?.tracker.track(event: .login)
                self?.tracker.track(event: .loginByPhoneSuccess)
                self?.view.openMainScreeen()
                
            case .failure(let error):
                self?.tracker.track(event: .loginByPhoneFailure)
                self?.view.showError(message: error.localizedString)
            }
        }
    }
    
    func showInfo() {
        let info = NSMutableAttributedString(
            string: "Код выслан на ",
            font: .appFont(ofSize: 13)
        )
        
        let phoneString = NSAttributedString(
            string: phone,
            font: .appFont(ofSize: 13, style: .semibold)
        )
        
        info.append(phoneString)
        
        view.displayInfo(infoString: info)
    }
    
    func getNewConfirmationCode() {
        view.showLoading()
        
        authService.requestSmsVerificationCode(for: phone) { [weak self] result in
            self?.view.hideLoading()
            
            switch result {
            case .success:
                break
            case .failure(let error):
                self?.view.showError(message: error.localizedString)
            }
        }
    }
}
