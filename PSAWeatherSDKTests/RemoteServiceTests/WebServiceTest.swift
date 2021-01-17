//
//  WebServiceTest.swift
//  PSAWeatherSDKTests
//
//  Created by Mohamed Lamine Belfekih on 17/01/2021.
//

import XCTest
@testable import PSAWeatherSDK

class WebServiceTest: XCTestCase {
    
    var webService: WebService?
    let session = NetworkSessionMock()
    
    override func setUp() {
        super.setUp()
        webService = WebService(session: session)
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func test_LoadData_Success() {
        let expectation = self.expectation(description: "Data loaded")
        guard let bundle = Bundle(for: type(of: self)).path(forResource: "CurrentWeather", ofType: "json") else {
            fatalError("wrong bundle")
        }
        guard let url = URL(string: "file://"+bundle) else{
            fatalError("wrong url")
        }
        guard let expectedData = try? Data(contentsOf: url) else {
            fatalError("No data for url \(url)")
        }
        
        session.data = expectedData
        var mockCurrentCityName = ""
        guard let webService = webService else {
            fatalError("no request Handler")
        }
        let resource = Resource<CurrentCityWeatherModel>(url: URL(string: "https://www.google.com/")!)
        webService.load(resource: resource) { result in
            expectation.fulfill()
            switch result {
            case .success(let result):
                mockCurrentCityName = result.name
            case .failure( _):
                print("")
            }
        }
        waitForExpectations(timeout: 2)
        XCTAssertFalse(mockCurrentCityName.isEmpty)
        XCTAssertEqual(mockCurrentCityName, "PSAWeatherSDKCity")
    }
    
    func test_loadData_fail() {
        session.data = nil
        session.error = NetWorkError.networkError
        var actualError: Error?
        
        guard let webService = webService else {
            fatalError("no request Handler")
        }
        let resource = Resource<CurrentCityWeatherModel>(url: URL(string: "https://www.google.com/")!)
        webService.load(resource: resource) { result in
            switch result {
            case .success(_):
                print("")
            case .failure(let error):
                actualError = error
            }
        }
        XCTAssertNotNil(actualError)
    }
}
