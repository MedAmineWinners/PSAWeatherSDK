//
//  WeatherDetailsInteractorTest.swift
//  PSAWeatherSDKTests
//
//  Created by Mohamed Lamine Belfekih on 18/01/2021.
//

import XCTest
@testable import PSAWeatherSDK

class TestWeatherDetailsInteractor: XCTestCase {
    let session = NetworkSessionMock()
    let psaWeatherSDKMock = PSAWeatherSDKDetailsMock()
    var weatherDetailsInteractor: WeatherDetailsInteractor?
    var currentCityWeather: CurrentCityWeather?
    override func setUp() {
        super.setUp()
        weatherDetailsInteractor = WeatherDetailsInteractor(weatherDetailsProtocol: psaWeatherSDKMock)
        weatherDetailsInteractor?.webService = WebService(session: session)
        currentCityWeather = CurrentCityWeather(context: PersistenceService.context)
    }

    override func tearDown() {
        super.tearDown()
    }
    
    func test_getWeatherDetails_with_success_response() {
        guard let bundle = Bundle(for: type(of: self)).path(forResource: "WeatherDetails", ofType: "json") else {
            fatalError("wrong bundle")
        }
        guard let url = URL(string: "file://"+bundle) else{
            fatalError("wrong url")
        }
        guard let expectedData = try? Data(contentsOf: url) else {
            fatalError("No data for url \(url)")
        }
        
        let expectation = self.expectation(description: "Data fetched and saved")
        session.data = expectedData
        session.error = nil
        weatherDetailsInteractor?.getWeatherDetails(of: currentCityWeather!, apiKey: "key")
        fullfillExpectation(expectation: expectation, after: 4)
        waitForExpectations(timeout: 4)
        XCTAssertTrue(psaWeatherSDKMock.weatherDetailsProtocolSucceedCalled)
    }
    
    func test_getWeatherDetails_with_failure_response() {
        session.data = nil
        session.error = NetWorkError.domainError
        weatherDetailsInteractor?.getWeatherDetails(of: currentCityWeather!, apiKey: "key")
        XCTAssertTrue(psaWeatherSDKMock.weatherDetailsProtocolFailedCalled)
    }
    
    func fullfillExpectation(expectation: XCTestExpectation, after seconds: Double) {
        _ = Timer.scheduledTimer(withTimeInterval: seconds, repeats: false) { timer in
            expectation.fulfill()
        }
    }
}

class PSAWeatherSDKDetailsMock: WeatherDetailsProtocol {
    var weatherDetailsProtocolSucceedCalled = false
    var weatherDetailsProtocolFailedCalled = false
    
    func weatherDetailsProtocolSucceed(weatherDetails: WeatherDetails) {
        weatherDetailsProtocolSucceedCalled = true
    }
    
    func weatherDetailsProtocolFailed(error: String) {
        weatherDetailsProtocolFailedCalled = true
    }
}
