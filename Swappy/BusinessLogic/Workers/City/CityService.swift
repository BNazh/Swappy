//
//  CityService.swift
//  Swappy
//
//  Created by Mihail on 14/07/2019.
//  Copyright © 2019 SwappyTeam. All rights reserved.
//

protocol CityService: AnyObject {
    
    // MARK: - Properties
    
    var cities: [City] { get }
    
    var selectedCity: City? { get set }
    
    // MARK: - Functions
    
    func updateCitiesList(_ closure: ResultCallback<[City]>)
}
