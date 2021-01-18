//
//  CityDetailsInteractor.swift
//  PSAWeatherSDK
//
//  Created by Mohamed Lamine Belfekih on 17/01/2021.
//

import Foundation
class WeatherDetailsInteractor {
    var weatherDetailsProtocol: WeatherDetailsProtocol?
    var webService = WebService()
    
    init(weatherDetailsProtocol: WeatherDetailsProtocol) {
        self.weatherDetailsProtocol = weatherDetailsProtocol
    }
    
    /// this method check reachability and try to load  *CurrentCitiesWeather* from CoreData if no reachability or from api Call
    /// - Returns : trigger *WeatherDetailsProtocolSucceed* in success
    /// - Returns : trigger *WeatherDetailsProtocolFailed* in success
    func getWeatherDetails(of currentCityWeather: CurrentCityWeather, apiKey: String?) {
        if Reachability.isConnectedToNetwork() {
            getRemoteWeatherDetails(of: currentCityWeather, apiKey: apiKey)
        } else {
            getSavedWeatherDetails(of: currentCityWeather)
        }
    }
    /// this method request the weather details of a given *CurrentCityWeather* and save it to CoreData  and trigger the succeed and failed *WeatherDetailsProtocol* in case of success or fail
    private func getRemoteWeatherDetails(of currentCityWeather: CurrentCityWeather, apiKey: String?) {
        let latitue = currentCityWeather.coord?.lat ?? 0.0
        let longitude = currentCityWeather.coord?.lon ?? 0.0
        let queryItems = URLGenerator().weatherDetailsQueryItems(with: latitue, lon: longitude, apiKey: apiKey)
        guard let url = URLGenerator().getUrl(with: .weatherCall, queryItems: queryItems) else {
            fatalError()
        }
        let resource = Resource<WeatherDetailsModel>(url: url)
        webService.load(resource: resource) { result in
            switch result {
            case .success(let weatherDetails):
                self.saveWeatherDetails(of: currentCityWeather, with: weatherDetails)
            case .failure(let error):
                self.weatherDetailsProtocol?.weatherDetailsProtocolFailed(error: error.localizedDescription)
            case .apiFailure(let apiError):
                self.weatherDetailsProtocol?.weatherDetailsProtocolFailed(error: apiError.message)
            }
        }
    }
    
    /// this method request the saved *WeatherDetails* of a *CurrentCitieWeather*
    /// - Returns  trigger the succeed and failed *CurrentCitiesWeatherProtocol* in case of success or fail
    private func getSavedWeatherDetails(of currentCityWeather: CurrentCityWeather) {
        let savedWeatherDetails = currentCityWeather.weatherDetails
        weatherDetailsProtocol?.weatherDetailsProtocolSucceed(weatherDetails: savedWeatherDetails)
    }
}

extension WeatherDetailsInteractor {
    
    /// this method delete the saved *WeatherDetails* of a given *CurrentCityWeather* from coreData if it already exist
    /// try to save *WeatherDetailsModel*
    /// - returns trigger the success *WeatherDetailsProtocol* if the weather is successfully added to coredata
    /// - returns trigger the failed *WeatherDetailsProtocol* if the weather failed adding to coredata
    private func saveWeatherDetails(of currentCityWeather: CurrentCityWeather, with weatherDetailsModel: WeatherDetailsModel) {
        let coreDataInteractor = WeatherDetailsCoreDataInteractor()
        coreDataInteractor.removedSavedWeatherFromCoreData(of: currentCityWeather)
        switch coreDataInteractor.saveWeatherDetails(with: weatherDetailsModel, for: currentCityWeather) {
        case .success(let weatherDetails):
            weatherDetailsProtocol?.weatherDetailsProtocolSucceed(weatherDetails: weatherDetails)
        case .failure(let error):
            weatherDetailsProtocol?.weatherDetailsProtocolFailed(error: error.localizedDescription)
            
        }
    }
}
