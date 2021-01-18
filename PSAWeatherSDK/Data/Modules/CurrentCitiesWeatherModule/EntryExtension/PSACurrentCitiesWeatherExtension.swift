//
//  PSACurrentCitiesWeatherExtension.swift
//  PSAWeatherSDK
//
//  Created by Mohamed Lamine Belfekih on 18/01/2021.
//

import Foundation
extension PSAWeatherSDK {
    public func getSavedCitiesCurrentWeatherList() {
        let interactor = CurrentCitiesWeatherInteractor(currentCitiesWeatherProtocol: self)
        interactor.getCurrentCitiesWeather(with: self.apiKey)
    }
}

extension PSAWeatherSDK: CurrentCitiesWeatherProtocol {
    func CurrentCitiesWeatherProtocolSucceed(currentCitiesWeather: [CurrentCityWeather]) {
        self.delegate?.PSAWeatherSDKDidFinishWithSuccess(result: currentCitiesWeather)
    }
    
    func CurrentCitiesWeatherProtocolFailed(with error: String) {
        self.delegate?.PSAWeatherSDKDidFailWithError(error: error)
    }
}
