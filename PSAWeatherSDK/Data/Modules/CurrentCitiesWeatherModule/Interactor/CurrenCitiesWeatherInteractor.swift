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
    
    /// this method check reachability and try to load  *CurrentCitiesWeather* from CoreData if no reachability or from api Call
    func getCurrentCitiesWeather(with apiKey: String?) {
        if Reachability.isConnectedToNetwork() {
            getRemoteCurrentCitiesWeather(with: apiKey)
        } else {
            getSavedCitiesWeather()
        }
    }
    /// this method request the current cities weather list and save it and trigger the succeed and failed *CurrentCitiesWeatherProtocol* in case of success or fail
    private func getRemoteCurrentCitiesWeather(with apiKey: String?) {
        let queryItems = URLGenerator().currentCitiesWeatherQueryItems(cityIds: savedCitiesIds(), apiKey: apiKey)
        guard let url = URLGenerator().getUrl(with: .cityList, queryItems: queryItems) else { fatalError() }
        let resource = Resource<CurrentCitiesWeatherListModel>(url: url)
        
        webService.load(resource: resource) { result in
            switch result {
            case .success(let currentCitiesWeatherModel):
                self.saveCitiesCurrentWeather(currentCitiesWeatherModel.list)
            case .failure(let error):
                self.currentCitiesWeatherProtocol?.CurrentCitiesWeatherProtocolFailed(with: error.localizedDescription)
            case .apiFailure(let apiError):
                self.currentCitiesWeatherProtocol?.CurrentCitiesWeatherProtocolFailed(with: apiError.message)
            }
        }
    }
    
    /// this method fetch saved *[CurrentCityWeather]* and trigger a success with the saved value
    /// - Remark the saved value can be an empty array, means no data is saved on CoreData
    private func getSavedCitiesWeather() {
        let savedCitiesWeather = CurrentCityWeatherCoreDataInteractor().getSavedWeathersFromCoreData()
        currentCitiesWeatherProtocol?.CurrentCitiesWeatherProtocolSucceed(currentCitiesWeather: savedCitiesWeather)
    }
}

extension CurrentCitiesWeatherInteractor {
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
