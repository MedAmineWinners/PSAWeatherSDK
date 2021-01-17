//
//  CityDetailsProtocol.swift
//  PSAWeatherSDK
//
//  Created by Mohamed Lamine Belfekih on 17/01/2021.
//

import Foundation

protocol WeatherDetailsProtocol {
    /// delegate function triggered when CityDetailsInteractor request *Succeed*
    /// - Returns: WeatherDetails in success case
    func weatherDetailsProtocolSucceed(weatherDetails: WeatherDetails)
    
    /// delegate function triggered when CityDetailsInteractor request *Failed*
    /// - Returns: string error in failure case
    func weatherDetailsProtocolFailed(error: String)
}
