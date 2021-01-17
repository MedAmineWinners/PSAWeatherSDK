//
//  AddCityInteractor.swift
//  PSAWeatherSDK
//
//  Created by Mohamed Lamine Belfekih on 16/01/2021.
//

import Foundation

class AddCityInteractor {
    
    var addCityProtocol: AddCityProtocol?
    var webService = WebService()
    
    init(addCityProtocol: AddCityProtocol) {
        self.addCityProtocol = addCityProtocol
    }
    
    /// this method request the current city weather and trigger the succeed and failed addCityProtocol in case of success or fail
    func addCity(with cityName: String, apiKey: String?) {
        let queryItems = URLGenerator().currentCityWeatherQueryItems(cityName: cityName, apiKey: apiKey)
        guard let url = URLGenerator().getUrl(with: .cityCall, queryItems: queryItems) else { fatalError() }
        let resource = Resource<CurrentCityWeatherModel>(url: url)
        
        webService.load(resource: resource) { result in
            switch result {
            case .success(let cityWeather):
                self.saveCityCurrentWeather(cityWeather)
            case .failure(let error):
                self.addCityProtocol?.addCityProtocolFailed(with: error.localizedDescription)
            }
        }
    }
    
    /// this method delete the saved cityWeather from coreData if it already exist
    /// try to save Current city weather
    /// - returns trigger the success *addCityProtocol* if the weather is successfully added to coredata
    /// - returns trigger the failed *addCityProtocol* if the weather failed adding to coredata
    private func saveCityCurrentWeather(_ cityWeather: CurrentCityWeatherModel) {
        let coreDataInteractor = CurrentCityWeatherCoreDataInteractor()
        coreDataInteractor.removedSavedWeatherFromCoreData(with: cityWeather.name)
        switch coreDataInteractor.saveCurrentCityWeather(cityWeather) {
        case .success(let currentCityWeather):
            addCityProtocol?.addCityProtocolSucceed(currentCityWeather: currentCityWeather)
        case .failure(let error):
            addCityProtocol?.addCityProtocolFailed(with: error.localizedDescription)
        }
    }
}


