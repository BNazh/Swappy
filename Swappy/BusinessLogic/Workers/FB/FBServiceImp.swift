//
//  FBServiceImp.swift
//  Swappy
//
//  Created by Mihail on 08/05/2019.
//  Copyright © 2019 SwappyTeam. All rights reserved.
//

import FBSDKLoginKit
import FacebookLogin

final class FBServiceImp {
    
    // MARK: - Properties
    
    let loginManager = LoginManager()
}

extension FBServiceImp: FBService {
    
    func login(viewController: UIViewController, closure: @escaping (ResultCallback<FBLoginResponse>)) {
        loginManager.logIn(permissions: [.email], viewController: viewController) { result in
            switch result {
            case .success(let grantedPermissions, _, let token):
                break
                
            case .cancelled, .failed(_):
                closure(.failure(.unknown))
            }
        }
    }
}
