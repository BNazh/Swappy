//
//  SingleSelectionRoute.swift
//  Swappy
//
//  Created by Mihail on 25/07/2019.
//  Copyright © 2019 SwappyTeam. All rights reserved.
//

import UIKit

protocol SingleSelectionRoute: AnyObject {
    
    var selectionContainer: UIViewController? { get }
}

extension SingleSelectionRoute {
    
    func openSelection(delegate: SingleSelectionDelegate,
                       input: SingleSelectionInput) {
        
        let controller: SingleSelectionViewController
        controller = UIStoryboard.createViewController()
        
        controller.presenter.setup(delegate: delegate, input: input)
        
        selectionContainer?.present(controller, animated: true, completion: nil)
    }
}
