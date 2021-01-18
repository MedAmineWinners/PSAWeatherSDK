//
//  CurrentCitiesWeatherInteractorTest.swift
//  PSAWeatherSDKTests
//
//  Created by Mohamed Lamine Belfekih on 18/01/2021.
//

import XCTest
@testable import PSAWeatherSDK

class TestCurrentCitiesWeatherInteractor: XCTestCase {
    let session = NetworkSessionMock()
    let psaWeatherSDKMock = PSACurrentCitiesWeatherSDKMock()
    var interactor: CurrentCitiesWeatherInteractor?
    override func setUp() {
        super.setUp()
        interactor = CurrentCitiesWeatherInteractor(currentCitiesWeatherProtocol: psaWeatherSDKMock)
        interactor?.webService = WebService(session: session)
    }

    override func tearDown() {
        super.tearDown()
    }
    
    func test_addCity_with_success_response() {
        guard let bundle = Bundle(for: type(of: self)).path(forResource: "CurrentCitiesWeather", ofType: "json") else {
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
        interactor?.getCurrentCitiesWeather(with: "key")
        fullfillExpectation(expectation: expectation, after: 4)
        waitForExpectations(timeout: 4)
        XCTAssertTrue(psaWeatherSDKMock.currentCitiesWeatherProtocolSucceedCalled)
    }
    
    func test_addCity_with_failure_response() {
        session.data = nil
        session.error = NetWorkError.domainError
        interactor?.getCurrentCitiesWeather(with: "key")
        XCTAssertTrue(psaWeatherSDKMock.currentCitiesWeatherProtocolFailedCalled)
    }
    
    func fullfillExpectation(expectation: XCTestExpectation, after seconds: Double) {
        _ = Timer.scheduledTimer(withTimeInterval: seconds, repeats: false) { timer in
            expectation.fulfill()
        }
    }
}

class PSACurrentCitiesWeatherSDKMock: CurrentCitiesWeatherProtocol {
    var currentCitiesWeatherProtocolSucceedCalled = false
    var currentCitiesWeatherProtocolFailedCalled = false
    
    func CurrentCitiesWeatherProtocolSucceed(currentCitiesWeather: [CurrentCityWeather]) {
        currentCitiesWeatherProtocolSucceedCalled = true
    }
    
    func CurrentCitiesWeatherProtocolFailed(with error: String) {
        currentCitiesWeatherProtocolFailedCalled = true
    }

 
}
