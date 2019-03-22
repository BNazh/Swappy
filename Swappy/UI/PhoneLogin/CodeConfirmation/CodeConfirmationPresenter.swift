//
//  CodeConfirmationPresenter.swift
//  Swappy
//
//  Created by Mihail on 21/03/2019.
//  Copyright © 2019 SwappyTeam. All rights reserved.
//

protocol CodeConfirmationPresenter: class {
    
    func setPhone(_ phone: String)
    func authenticate(with code: String)
}

final class CodeConfirmationPresenterImp {
    
    private unowned let view: CodeConfirmationView
    private let authService: AuthService
    
    private var phone: String = ""
    
    init(view: CodeConfirmationView, authService: AuthService) {
        self.view = view
        self.authService = authService
    }
}


extension CodeConfirmationPresenterImp: CodeConfirmationPresenter {
    
    func setPhone(_ phone: String) {
        self.phone = phone
    }
    
    func authenticate(with code: String) {
        authService.authenticate(phone: phone, code: code) { result in
            switch result {
            case .success:
                view.
            case .failure(let error):
                view.show
            }
        }
    }
}
