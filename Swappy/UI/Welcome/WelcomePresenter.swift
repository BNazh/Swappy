//
//  WelcomePresenter.swift
//  Swappy
//
//  Created by Mihail on 14/07/2019.
//  Copyright © 2019 SwappyTeam. All rights reserved.
//

protocol WelcomePresenter {
    
}

final class WelcomePresenterImp {
    
    // MARK: - Properties
    
    unowned let view: WelcomeView
    
    private let keychainStore: KeychainStore
    private let cityService: CityService
    
    
    // MARK: - Init
    
    init(view: WelcomeView)
}
