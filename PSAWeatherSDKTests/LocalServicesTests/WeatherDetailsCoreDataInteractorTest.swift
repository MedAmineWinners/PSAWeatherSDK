//
//  WeatherDetailsCoreDataInteractorTest.swift
//  PSAWeatherSDKTests
//
//  Created by Mohamed Lamine Belfekih on 17/01/2021.
//

import XCTest
@testable import PSAWeatherSDK

class WeatherDetailsCoreDataInteractorTest: XCTestCase {

    var data: Data?
    var weatherDetailsModel: WeatherDetailsModel?
    var savedWeather = WeatherDetails()
   let coreDataInteractor = WeatherDetailsCoreDataInteractor()
    override func setUp() {
        super.setUp()
        guard let bundle = Bundle(for: type(of: self)).path(forResource: "WeatherDetails", ofType: "json") else {
            fatalError("wrong bundle")
        }
        guard let url = URL(string: "file://"+bundle) else{
            fatalError("wrong url")
        }
        guard let expectedData = try? Data(contentsOf: url) else {
            fatalError("No data for url \(url)")
        }
        weatherDetailsModel = try? JSONDecoder().decode(WeatherDetailsModel.self, from: expectedData)
    }

    func test_WeatherDetails_Saved_to_coreData() {
        let currenCityWeatherMock = CurrentCityWeather(context: PersistenceService.context)
        if let weatherDetailsModel = weatherDetailsModel {
            let savingStatus = coreDataInteractor.saveWeatherDetails(with: weatherDetailsModel, for: currenCityWeatherMock)
            switch savingStatus {
            case .success(let result):
                XCTAssertNotNil(result.dailyForcast)
                XCTAssertEqual(result.dailyForcast?.count, 2)
                XCTAssertEqual(result.hourlyForcast?.count, 2)
            case .failure(_):
                print("adding failed")
            }
        }
    }
        
    override func tearDown() {
        super.tearDown()
        WeatherDetailsCoreDataInteractor().removeSavedWeathersFromCoreData()
    }

    func testExample() throws {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
}
