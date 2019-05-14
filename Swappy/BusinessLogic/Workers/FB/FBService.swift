//
//  FBService.swift
//  Swappy
//
//  Created by Mihail on 08/05/2019.
//  Copyright © 2019 SwappyTeam. All rights reserved.
//

import UIKit

struct FBLoginResponse {
    let email: String
    let accessToken: String
    
    init(accessToken: String, email: String) {
        self.email = email
        self.accessToken = accessToken
    }
}

protocol FBService {
    
    func login(viewController: UIViewController, closure: @escaping (ResultCallback<Void>))
}

