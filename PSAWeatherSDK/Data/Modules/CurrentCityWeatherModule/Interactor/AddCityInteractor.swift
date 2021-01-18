//
//  AddCityInteractor.swift
//  PSAWeatherSDK
//
//  Created by Mohamed Lamine Belfekih on 16/01/2021.
//

import Foundation

class CurrentCityWeatherInteractor {
    
    var addCityProtocol: AddCityProtocol?
    var removeCityProtocol: RemoveCityProtocol?
    var webService = WebService()
    
    init(addCityProtocol: AddCityProtocol, removeCityProtocol: RemoveCityProtocol) {
        self.addCityProtocol = addCityProtocol
        self.removeCityProtocol = removeCityProtocol
    }
    
    /// this method check reachability and try to add a *CurrentCityWeather* to CoreData
    func addCity(with cityName: String, apiKey: String?) {
        if Reachability.isConnectedToNetwork() {
            addCurrentCityWeather(with: cityName, apiKey: apiKey)
        } else {
            addCityProtocol?.addCityProtocolFailed(with: NetWorkError.reachabilityError.localizedDescription)
        }
    }
    /// this method request the current city weather and trigger the succeed and failed addCityProtocol in case of success or fail
    private func addCurrentCityWeather(with cityName: String, apiKey: String?) {
        let queryItems = URLGenerator().currentCityWeatherQueryItems(cityName: cityName, apiKey: apiKey)
        guard let url = URLGenerator().getUrl(with: .cityCall, queryItems: queryItems) else { fatalError() }
        let resource = Resource<CurrentCityWeatherModel>(url: url)
        
        webService.load(resource: resource) { result in
            switch result {
            case .success(let cityWeather):
                self.saveCityCurrentWeather(cityWeather)
            case .failure(let error):
                self.addCityProtocol?.addCityProtocolFailed(with: error.localizedDescription)
            case .apiFailure(let apiError):
                self.addCityProtocol?.addCityProtocolFailed(with: apiError.message)
            }
        }
    }
    
    /// this method check if *CurrentCityWeather* exists in database and remove it
    /// - returns trigger the success *RemoveCityProtocol* if the weather is successfully deleted to coredata
    /// - returns trigger the failed *RemoveCityProtocol* if the weather failed deleting from coredata
    func removeCurrentCityWeather(currentCityWeather: CurrentCityWeather) {
        let coreDataInteractor = CurrentCityWeatherCoreDataInteractor()
        guard let savedWeathers = coreDataInteractor.getSavedWeathersFromCoreData() else {
            removeCityProtocol?.removeCityProtocolFailed(with: "Current CityWeather Not found in database")
            return
        }
        
        if savedWeathers.map({ $0.cityName }).contains(currentCityWeather.cityName){
            removeCityProtocol?.removeCityProtocolSucceed()
        }else {
            removeCityProtocol?.removeCityProtocolFailed(with: "Current CityWeather Not found in database")
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


