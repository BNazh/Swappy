//
//  ProductsCatalogWorker.swift
//  Swappy
//
//  Created by Бабаев Михаил Михайлович on 07/03/2019.
//  Copyright © 2019 SwappyTeam. All rights reserved.
//

import Alamofire

protocol ProductCatalogWorker {
    
    func getProducts(callback:  @escaping ResultCallback<[Product]>)
}