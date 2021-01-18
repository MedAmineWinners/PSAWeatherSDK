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
            default:
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
            case .failure(let error):
                actualError = error
            default:
                print("")
            }
        }
        XCTAssertNotNil(actualError)
    }
    
    func test_loadData_fail_with_ApiError() {
        let expectation = self.expectation(description: "Data loaded")
        var apiFailureTriggered = false
        var apiErrorMessage = ""
        guard let bundle = Bundle(for: type(of: self)).path(forResource: "ApiError", ofType: "json") else {
            fatalError("wrong bundle")
        }
        guard let url = URL(string: "file://"+bundle) else{
            fatalError("wrong url")
        }
        guard let expectedData = try? Data(contentsOf: url) else {
            fatalError("No data for url \(url)")
        }
        
        session.data = expectedData
        let resource = Resource<CurrentCityWeatherModel>(url: URL(string: "https://www.google.com/")!)
        webService?.load(resource: resource, completion: { result in
            expectation.fulfill()
            switch result {
            case .apiFailure(let error):
                apiFailureTriggered = true
                apiErrorMessage = error.message
            default:
                print("Test Fail")
            }
        })
        
        waitForExpectations(timeout: 2)
        XCTAssertTrue(apiFailureTriggered)
        XCTAssertEqual(apiErrorMessage, "We have not errors! we are just testing")
    }
}
