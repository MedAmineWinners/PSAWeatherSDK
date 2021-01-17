//
//  AddCityInteractor.swift
//  PSAWeatherSDK
//
//  Created by Mohamed Lamine Belfekih on 16/01/2021.
//

import Foundation

class AddCityInteractor {
    
    var addCityProtocol: AddCityProtocol?
    
    init(addCityProtocol: AddCityProtocol) {
        self.addCityProtocol = addCityProtocol
    }
    
    func addCity(with cityName: String, apiKey: String?) {
        let queryItems = URLGenerator().currentCityWeatherQueryItems(cityName: cityName, apiKey: apiKey)
        guard let url = URLGenerator().getUrl(with: .cityCall, queryItems: queryItems) else { fatalError() }
        let resource = Resource<CurrentCityWeatherModel>(url: url)
        
        WebService().load(resource: resource) { result in
            switch result {
            case .success(let cityWeather):
                self.saveCityCurrentWeather(cityWeather)
            case .failure(let error):
                self.addCityProtocol?.addCityProtocolFailed(with: error.localizedDescription)
            }
        }
    }
    
    private func saveCityCurrentWeather(_ cityWeather: CurrentCityWeatherModel) {
        switch CoreDataInteractor().saveCurrentCityWeather(cityWeather) {
        case .success(let currentCityWeather):
            addCityProtocol?.addCityProtocolSucceed(currentCityWeather: currentCityWeather)
        case .failure(let error):
            addCityProtocol?.addCityProtocolFailed(with: error.localizedDescription)
        }
    }
}


