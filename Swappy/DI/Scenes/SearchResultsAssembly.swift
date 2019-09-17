//
//  SearchResultsAssembly.swift
//  Swappy
//
//  Created by Mihail on 14/09/2019.
//  Copyright © 2019 SwappyTeam. All rights reserved.
//

import Swinject

final class SearchResultsAssembly: Assembly {
    
    func assemble(container: Container) {
        container.register(SearchResultsPresenter.self) { (r, view: SearchResultsViewController) in
            return SearchResultsPresenterImp(
                view: view,
                router: r.resolve(argument: view),
                searchService: r.resolve(),
                pagerService: r.resolve()
            )
        }
        
        container.register(SearchResultsRouter.self) { (r, viewController: SearchResultsViewController) in
            return SearchResultsRouterImp(viewController: viewController)
        }
        
        container.storyboardInitCompleted(SearchResultsViewController.self) { (resolver, viewController) in
            let presenter = container.resolve(SearchResultsPresenter.self, argument: viewController)!
            
            viewController.presenter = presenter
            viewController.dataDisplayManager = resolver.resolve()
        }
    }
}
