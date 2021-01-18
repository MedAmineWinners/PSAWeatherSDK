//
//  CurrentCitiesWeatherListCoreDataInteractor.swift
//  PSAWeatherSDK
//
//  Created by Mohamed Lamine Belfekih on 18/01/2021.
//

import Foundation
import CoreData

class CurrentCitiesListCoreDataInteractor {
    
    /// saveCurrentCitiesWeatherList method allow us to save the CurrentCityWeatherList to core data
    /// - Parameter currentCityWeatherModelList:  the fetched *CurrentCitiesWeatherListModel*
    /// - Returns a Result of **[CurrentCityWeather]** or an **error**
    func saveCurrentCitiesWeatherList(currentCityWeatherModelList: [CurrentCityWeatherModel]) -> Result<[CurrentCityWeather], Error>{
        let coreDataInteractor = CurrentCityWeatherCoreDataInteractor()
        var currentCitiesWeatherList = [CurrentCityWeather] ()
        currentCityWeatherModelList.forEach {
            let savingResult = coreDataInteractor.saveCurrentCityWeather($0)
            switch savingResult {
            case .success(let savedCityWeather):
                currentCitiesWeatherList.append(savedCityWeather)
            case .failure(_):
                return
            }
        }
        if currentCitiesWeatherList.count == currentCityWeatherModelList.count {
            return .success(currentCitiesWeatherList)
        }
        return .failure(CoreDataError.savingError)
    }
}
