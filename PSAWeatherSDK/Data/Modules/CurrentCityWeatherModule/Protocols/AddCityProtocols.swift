//
//  File.swift
//  PSAWeatherSDK
//
//  Created by Mohamed Lamine Belfekih on 16/01/2021.
//

import Foundation

protocol AddCityProtocol {
    /// delegate function triggered when CurrentCityWeatherInteractor add request *Succeed*
    /// - Returns: CurrentCityWeather
    func addCityProtocolSucceed(currentCityWeather: CurrentCityWeather)
    
    /// delegate function triggered when CurrentCityWeatherInteractor request *failed*
    /// - Returns: error
    func addCityProtocolFailed(with error: String)
}

protocol RemoveCityProtocol {
    
    /// delegate function triggered when CurrentCityWeatherInteractor remove request *Succeed*
    func removeCityProtocolSucceed()
    
    /// delegate function triggered when CurrentCityWeatherInteractor request *failed*
    /// - Returns: error
    func removeCityProtocolFailed(with error: String)
}
