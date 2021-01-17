//
//  PSAWeatherSDKExtension.swift
//  PSAWeatherSDK
//
//  Created by Mohamed Lamine Belfekih on 17/01/2021.
//

import Foundation

extension PSAWeatherSDK {
    public func getCityWeatherDetails(of currentCityWeather: CurrentCityWeather) {
        let weatherDetailsInteractor = WeatherDetailsInteractor(weatherDetailsProtocol: self)
        weatherDetailsInteractor.getWeatherDetails(of: currentCityWeather, apiKey: self.apiKey)
    }
}

extension PSAWeatherSDK: WeatherDetailsProtocol {
    func weatherDetailsProtocolSucceed(weatherDetails: WeatherDetails) {
        self.delegate?.PSAWeatherSDKDidFinishWithSuccess(result: weatherDetails)
    }
    
    func weatherDetailsProtocolFailed(error: String) {
        self.addCityProtocolFailed(with: error)
    }
}
