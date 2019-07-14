//
//  CityService.swift
//  Swappy
//
//  Created by Mihail on 14/07/2019.
//  Copyright © 2019 SwappyTeam. All rights reserved.
//

protocol CityService {
    
    // MARK: - Properties
    
    var cities: [City] { get }
    
    // MARK: - Functions
    
    func updateCitiesList(_ closure: ResultCallback<[City]>)
}
