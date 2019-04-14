//
//  VKDelegate.swift
//  Swappy
//
//  Created by Mihail on 13/04/2019.
//  Copyright © 2019 SwappyTeam. All rights reserved.
//

import SwiftyVK
import UIKit

struct VKLoginResponse {
    let email: String
    let accessToken: String
    
    init(accessToken: String, email: String) {
        self.email = email
        self.accessToken = accessToken
    }
}

protocol VKService: class {
    
    func login(presentingHandler: @escaping (UIViewController) -> Void,
               callback: @escaping (Result<VKLoginResponse>)  -> Void)
}
