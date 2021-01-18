//
//  PSAWeatherSDKProtocol.swift
//  PSAWeatherSDK
//
//  Created by Mohamed Lamine Belfekih on 16/01/2021.
//

import Foundation

public protocol PSAWeatherSDKProtocol {
    
    /// configure SDK ***REQUIRED*** for  PSAWeatherSDK use
    /// - Parameter apiKey: the app key from weather API
    /// - Remark: without configuring the SDK, you are not able to use it's services.
    /// - Requires: a valid apiKey
    func configure(with apiKey: String)
    
    /// addCity method allow user to add a city to local database
    /// the method verify if the city exist, add it to database and return the city entity to the user
    /// - Parameter cityName: the name of the city
    /// - Remark: addCity method result will be tracked by **PSAWeatherSDKDelegate**
    func addCity(with cityName: String)
    
    
    /// removeCurrentCityWeather method allow user to remove a cityWeather from local database
    /// the method verify if the city exist, and remove it from the database
    /// - Parameter currentCityWeather: the currentCityWeather that user want to delete
    /// - Remark: addCity method result will be tracked by **PSAWeatherSDKDelegate**
    func removeCurrentCityWeather(currentCityWeather: CurrentCityWeather)
    
    
    /// getCityWeatherDetails method allow user to get weatherDetails
    /// the method result *Hourly* and *daily* forcast for a given currentCityWeather
    /// - Parameter currentCityWeather: the currentCityWeather
    /// - Remark: the method result will be tracked by **PSAWeatherSDKDelegate**
    func getCityWeatherDetails(of currentCityWeather: CurrentCityWeather)
    
    /// getSavedCitiesCurrentWeatherList method allow user to get all the current city weather saved to coreData
    /// the method result **[CurrentCityWeather]**
    /// - Remark: the method result will be tracked by **PSAWeatherSDKDelegate**
    func getSavedCitiesCurrentWeatherList()
    
    
}
