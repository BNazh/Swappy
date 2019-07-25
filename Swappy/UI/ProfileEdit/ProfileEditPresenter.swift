//
//  ProfileEditPresenter.swift
//  Swappy
//
//  Created by Mihail on 25/07/2019.
//  Copyright © 2019 SwappyTeam. All rights reserved.
//

struct ProfileEditRequest {
    let name: String
    let phone: String
    let city 
}

protocol ProfileEditPresenter: AnyObject {
    
    func reload
    func openCitySelection()
    func save()
    func logout()
}
