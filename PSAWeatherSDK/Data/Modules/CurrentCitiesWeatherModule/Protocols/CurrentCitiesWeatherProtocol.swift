//
//  CurrentCitiesWeatherProtocol.swift
//  PSAWeatherSDK
//
//  Created by Mohamed Lamine Belfekih on 18/01/2021.
//

import Foundation

protocol CurrentCitiesWeatherProtocol {
    /// delegate function triggered when CurrentCitiesWeatherProtocol request *Succeed*
    /// - Returns: [CurrentCityWeather]
    func CurrentCitiesWeatherProtocolSucceed(currentCitiesWeather: [CurrentCityWeather]?)
    
    /// delegate function triggered when CurrentCitiesWeatherProtocol request *failed*
    /// - Returns: error
    func CurrentCitiesWeatherProtocolFailed(with error: String)
}
