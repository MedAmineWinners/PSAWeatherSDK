//
//  PSAWeatherSDKExtension.swift
//  PSAWeatherSDK
//
//  Created by Mohamed Lamine Belfekih on 16/01/2021.
//

import Foundation


extension PSAWeatherSDK {
    public func addCity(with cityName: String) {
        let addCityInteractor = AddCityInteractor(addCityProtocol: self)
        addCityInteractor.addCity(with: cityName, apiKey: self.apiKey)
    }
}

extension PSAWeatherSDK: AddCityProtocol {
    func addCityProtocolSucceed(currentCityWeather: CurrentCityWeather) {
        self.delegate?.PSAWeatherSDKDidFinishWithSuccess(result: currentCityWeather)
    }
    
    func addCityProtocolFailed(with error: String) {
        self.delegate?.PSAWeatherSDKDidFailWithError(error: error)
    }
}
