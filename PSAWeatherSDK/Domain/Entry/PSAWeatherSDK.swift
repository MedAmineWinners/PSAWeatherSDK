//
//  PSAWeatherSDK.swift
//  PSAWeatherSDK
//
//  Created by Mohamed Lamine Belfekih on 16/01/2021.
//

import Foundation

/// PSAWeatherSDKDelegate used to track all PSAWeatherSDK requests.
/// All classes that need to get PSAWeatherSDK should conform to this protocol
/// - Returns: *PSAWeatherSDKDidFinishWithSuccess with a generic type on success
/// - Returns: *aareonSDKdidFailWithError* call if fail
public protocol PSAWeatherSDKDelegate {
    /// delegate function triggered when SDK request *Succeed*
    /// - Returns: T a generic result of the request
    func PSAWeatherSDKDidFinishWithSuccess<T: Codable>(result: T)
    
    /// delegate function triggered when SDK request *Fail*
    /// - Returns: request error message
    func PSAWeatherSDKDidFailWithError(string: Error)
}

/// PSAWeatherSDK class adopt PSAWeatherSDKProtocol and implement all it's methods
public class PSAWeatherSDK {
    public static let shared = PSAWeatherSDK()
    private init(){}
}
