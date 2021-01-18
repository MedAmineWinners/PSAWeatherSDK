//
//  File.swift
//  PSAWeatherSDK
//
//  Created by Mohamed Lamine Belfekih on 16/01/2021.
//

import Foundation

protocol AddCityProtocol {
    /// delegate function triggered when AddCityInteractor request *Succeed*
    /// - Returns: CurrentCityWeather
    func addCityProtocolSucceed(currentCityWeather: CurrentCityWeather)
    
    /// delegate function triggered when AddCityInteractor request *failed*
    /// - Returns: error
    func addCityProtocolFailed(with error: String)
}
