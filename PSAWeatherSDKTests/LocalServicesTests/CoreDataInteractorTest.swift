//
//  CoreDataInteractorTest.swift
//  PSAWeatherSDKTests
//
//  Created by Mohamed Lamine Belfekih on 17/01/2021.
//

import XCTest
@testable import PSAWeatherSDK

class LocalServiceTest: XCTestCase {

    var data: Data?
    var currentWeather: CurrentCityWeatherModel?
    var savedWeather = CurrentCityWeather()
   let coreDataInteractor = CoreDataInteractor()
    override func setUp() {
        super.setUp()
        guard let bundle = Bundle(for: type(of: self)).path(forResource: "CurrentWeather", ofType: "json") else {
            fatalError("wrong bundle")
        }
        guard let url = URL(string: "file://"+bundle) else{
            fatalError("wrong url")
        }
        guard let expectedData = try? Data(contentsOf: url) else {
            fatalError("No data for url \(url)")
        }
        currentWeather = try? JSONDecoder().decode(CurrentCityWeatherModel.self, from: expectedData)
    }

    func test_CurrentWeather_Saved_to_coreData() {
        let savingStatus = coreDataInteractor.saveCurrentCityWeather(currentWeather)
        switch savingStatus {
        case .success(let result):
            XCTAssertEqual(result.cityName, "PSAWeatherSDKCity")
        case .failure(_):
            print("adding failed")
        }
    }
    
    func test_SavedWeathers_removed_from_coreData() {
        coreDataInteractor.removeSavedWeathersFromCoreData()
        let testStillSaved = CoreDataInteractor().getSavedWeathersFromCoreData()
        XCTAssertEqual(testStillSaved?.count, 0)
    }
    
    func test_SavedWeather_removed_from_coreData() {
        coreDataInteractor.saveCurrentCityWeather(currentWeather)
        coreDataInteractor.removedSavedWeatherFromCoreData(with: "PSAWeatherSDKCity")
        if let testStillSaved = coreDataInteractor.getSavedWeathersFromCoreData() {
            XCTAssertFalse(testStillSaved.contains{
                $0.cityName == "PSAWeatherSDKCity"
            })
        }
    }
    
    override func tearDown() {
        super.tearDown()
        CoreDataInteractor().removeSavedWeathersFromCoreData()
    }

    func testExample() throws {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

}
