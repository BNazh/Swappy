//
//  SearchResultsAssembly.swift
//  Swappy
//
//  Created by Mihail on 14/09/2019.
//  Copyright © 2019 SwappyTeam. All rights reserved.
//

import SwinjectStoryboard
import Swinject

final class SearchResultsAssembly: Assembly {
    
    func assemble(container: Container) {
        
        container.storyboardInitCompleted(SearchResultsViewController.self) {
            (resolver, viewController) in
            
            //viewController.d
        }
    }
}

