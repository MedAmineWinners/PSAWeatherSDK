//
//  CurrenCitiesWeatherInteractor.swift
//  PSAWeatherSDK
//
//  Created by Mohamed Lamine Belfekih on 18/01/2021.
//

import Foundation

class CurrentCitiesWeatherInteractor {
    var currentCitiesWeatherProtocol: CurrentCitiesWeatherProtocol?
    var webService = WebService()
    
    init(currentCitiesWeatherProtocol: CurrentCitiesWeatherProtocol) {
        self.currentCitiesWeatherProtocol = currentCitiesWeatherProtocol
    }
    
    /// this method request the current cities weather list and trigger the succeed and failed currentCitiesWeatherProtocol in case of success or fail
    func getCurrentCitiesWeather(with apiKey: String?) {
        let queryItems = URLGenerator().currentCitiesWeatherQueryItems(cityIds: savedCitiesIds(), apiKey: apiKey)
        guard let url = URLGenerator().getUrl(with: .cityList, queryItems: queryItems) else { fatalError() }
        let resource = Resource<CurrentCitiesWeatherListModel>(url: url)
        
        webService.load(resource: resource) { result in
            switch result {
            case .success(let currentCitiesWeatherModel):
                self.saveCitiesCurrentWeather(currentCitiesWeatherModel.list)
            case .failure(let error):
                self.currentCitiesWeatherProtocol?.CurrentCitiesWeatherProtocolFailed(with: error.localizedDescription)
            }
        }
    }
    
    /// savedCitiesIds method return the ids of the saved cities in core data
    private func savedCitiesIds() -> [String] {
        if let savedCurrentCities = CurrentCityWeatherCoreDataInteractor().getSavedWeathersFromCoreData() {
            return savedCurrentCities.map{ String($0.cityId)}
        }
        return [String]()
    }
    
    /// this method delete the saved cities Weather from coreData if it already exist
    /// try to save CurrentCitiesWeatherList
    /// - returns trigger the success *currentCitiesWeatherProtocol* if the currentCities weather are successfully added to coredata
    /// - returns trigger the failed *currentCitiesWeatherProtocol* if the weather failed adding to coredata
    private func saveCitiesCurrentWeather(_ currentCitiesWeatherModel: [CurrentCityWeatherModel]) {
        let coreDataInteractor = CurrentCitiesListCoreDataInteractor()
        CurrentCityWeatherCoreDataInteractor().removeSavedWeathersFromCoreData()
        switch coreDataInteractor.saveCurrentCitiesWeatherList(currentCityWeatherModelList: currentCitiesWeatherModel) {

        case .success(let CurrentCitiesWeather):
            currentCitiesWeatherProtocol?.CurrentCitiesWeatherProtocolSucceed(currentCitiesWeather: CurrentCitiesWeather)
        case .failure(let error):
            currentCitiesWeatherProtocol?.CurrentCitiesWeatherProtocolFailed(with: error.localizedDescription)
        }
    }
}
