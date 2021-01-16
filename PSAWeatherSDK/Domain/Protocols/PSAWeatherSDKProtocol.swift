//
//  PSAWeatherSDKProtocol.swift
//  PSAWeatherSDK
//
//  Created by Mohamed Lamine Belfekih on 16/01/2021.
//

import Foundation

public protocol PSAWeatherSDKProtocol {
    
    
    /// addCity method allow user to add a city to local database
    /// the method verify if the city exist, add it to database and return the city entity to the user
    /// - Parameter cityName: the name of the city
    /// - Remark: addCity method result will be tracked by **PSAWeatherSDKDelegate**
    func addCity(with cityName: String)
}
