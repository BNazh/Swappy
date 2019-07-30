//
//  ProfileEditRouter.swift
//  Swappy
//
//  Created by Mihail on 25/07/2019.
//  Copyright © 2019 SwappyTeam. All rights reserved.
//

import UIKit

protocol ProfileEditRouter: SingleSelectionRoute {
    
}

final class ProfileEditRouterImp: ProfileEditRouter {
    
    // MARK: - Properties
    
    unowned let viewController: UIViewController
    
    var selectionContainer: UIViewController? {
        return viewController.tabBarController
    }
    
    // MARK: - Init
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
}
