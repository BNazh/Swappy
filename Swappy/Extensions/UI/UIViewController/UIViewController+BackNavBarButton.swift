//
//  UIViewController+BackNavBarButton.swift
//  Swappy
//
//  Created by Бабаев Михаил Михайлович on 03/04/2019.
//  Copyright © 2019 SwappyTeam. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func hideBackButton() {
        navigationController?.navigationBar.topItem?.title = " "
    }
}
