//
//  CityServiceImp.swift
//  Swappy
//
//  Created by Mihail on 14/07/2019.
//  Copyright © 2019 SwappyTeam. All rights reserved.
//

final class CityServiceImp {
    
}

// MARK: - CityService

extension CityServiceImp: CityService {
    
    var cities: [City] {
        return [
            City(id: "moscow", title: "Москва"),
            City(id: "sp", title: "Санкт-Петербург")
        ]
    }
    
    func updateCitiesList(_ closure: (Result<[City]>) -> Void) {
        closure(.success(cities))
    }
}

