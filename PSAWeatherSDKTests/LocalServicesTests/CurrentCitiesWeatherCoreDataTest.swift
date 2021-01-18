//
//  CurrentCitiesWeatherCoreDataTest.swift
//  PSAWeatherSDKTests
//
//  Created by Mohamed Lamine Belfekih on 18/01/2021.
//

import XCTest
@testable import PSAWeatherSDK

class CurrentCitiesWeatherCoreDataTest: XCTestCase {

    var data: Data?
    var currentCitiesWeather: CurrentCitiesWeatherListModel?
    var savedWeather = CurrentCityWeather()
   let coreDataInteractor = CurrentCitiesListCoreDataInteractor()
    override func setUp() {
        super.setUp()
        guard let bundle = Bundle(for: type(of: self)).path(forResource: "CurrentCitiesWeather", ofType: "json") else {
            fatalError("wrong bundle")
        }
        guard let url = URL(string: "file://"+bundle) else{
            fatalError("wrong url")
        }
        guard let expectedData = try? Data(contentsOf: url) else {
            fatalError("No data for url \(url)")
        }
        currentCitiesWeather = try? JSONDecoder().decode(CurrentCitiesWeatherListModel.self, from: expectedData)
    }

    func test_CurrentCitiesWeather_Saved_to_coreData() {
        let savingStatus = coreDataInteractor.saveCurrentCitiesWeatherList(currentCityWeatherModelList: currentCitiesWeather!.list)
        switch savingStatus {
        case .success(let result):
            XCTAssertEqual(result.count, 2)
        case .failure(_):
            print("adding failed")
        }
    }
    
    override func tearDown() {
        super.tearDown()
        CurrentCityWeatherCoreDataInteractor().removeSavedWeathersFromCoreData()
    }

    func testExample() throws {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

}
