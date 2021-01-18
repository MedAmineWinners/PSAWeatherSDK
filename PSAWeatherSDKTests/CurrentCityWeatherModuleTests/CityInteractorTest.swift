//
//  CityInteractorTest.swift
//  PSAWeatherSDKTests
//
//  Created by Mohamed Lamine Belfekih on 17/01/2021.
//

import XCTest
@testable import PSAWeatherSDK

class TestCurrentCityWeatherInteractor: XCTestCase {
    let session = NetworkSessionMock()
    let psaWeatherSDKMock = PSAWeatherSDKMock()
    var addCityInteractor: CurrentCityWeatherInteractor?
    override func setUp() {
        super.setUp()
        addCityInteractor = CurrentCityWeatherInteractor(addCityProtocol: psaWeatherSDKMock, removeCityProtocol: psaWeatherSDKMock)
        addCityInteractor?.webService = WebService(session: session)
    }

    override func tearDown() {
        super.tearDown()
    }
    
    func test_addCity_with_success_response() {
        guard let bundle = Bundle(for: type(of: self)).path(forResource: "CurrentWeather", ofType: "json") else {
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
        addCityInteractor?.addCity(with: "name", apiKey: "key")
        fullfillExpectation(expectation: expectation, after: 4)
        waitForExpectations(timeout: 4)
        XCTAssertTrue(psaWeatherSDKMock.addCityProtocolSucceedCalled)
    }
    
    func test_addCity_with_failure_response() {
        session.data = nil
        session.error = NetWorkError.domainError
        addCityInteractor?.addCity(with: "name", apiKey: "key")
        XCTAssertTrue(psaWeatherSDKMock.addCityProtocolFailedCalled)
    }
    
    func fullfillExpectation(expectation: XCTestExpectation, after seconds: Double) {
        _ = Timer.scheduledTimer(withTimeInterval: seconds, repeats: false) { timer in
            expectation.fulfill()
        }
    }
}

class PSAWeatherSDKMock: AddCityProtocol, RemoveCityProtocol {
    
    var addCityProtocolSucceedCalled = false
    var addCityProtocolFailedCalled = false
    
    var removeCityProtocolSucceedCalled = false
    var removeCityProtocolFailedCalled = false
   

    func addCityProtocolSucceed(currentCityWeather: CurrentCityWeather) {
        addCityProtocolSucceedCalled = true
    }
    
    func addCityProtocolFailed(with error: String) {
        addCityProtocolFailedCalled = true
    }
    
    func removeCityProtocolSucceed() {
        removeCityProtocolSucceedCalled = true
    }
    
    func removeCityProtocolFailed(with error: String) {
        removeCityProtocolFailedCalled = true
    }
}
