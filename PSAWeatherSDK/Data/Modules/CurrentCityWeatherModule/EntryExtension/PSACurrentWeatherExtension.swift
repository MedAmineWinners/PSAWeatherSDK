//
//  PSAWeatherSDKExtension.swift
//  PSAWeatherSDK
//
//  Created by Mohamed Lamine Belfekih on 16/01/2021.
//

import Foundation


extension PSAWeatherSDK {
    public func addCity(with cityName: String) {
        let interactor = CurrentCityWeatherInteractor(addCityProtocol: self, removeCityProtocol: self)
        interactor.addCity(with: cityName, apiKey: self.apiKey)
    }
    
    public func removeCurrentCityWeather(currentCityWeather: CurrentCityWeather) {
        let interactor = CurrentCityWeatherInteractor(addCityProtocol: self, removeCityProtocol: self)
        interactor.removeCurrentCityWeather(currentCityWeather: currentCityWeather)
    }
}

extension PSAWeatherSDK: AddCityProtocol, RemoveCityProtocol {
    
    func addCityProtocolSucceed(currentCityWeather: CurrentCityWeather) {
        self.delegate?.PSAWeatherSDKDidFinishWithSuccess(result: currentCityWeather)
    }
    
    func addCityProtocolFailed(with error: String) {
        self.delegate?.PSAWeatherSDKDidFailWithError(error: error)
    }
    
    func removeCityProtocolSucceed() {
        self.delegate?.PSAWeatherSDKDidFinishWithSuccess(result: true)
    }
    
    func removeCityProtocolFailed(with error: String) {
        self.delegate?.PSAWeatherSDKDidFailWithError(error: error)
    }
}
