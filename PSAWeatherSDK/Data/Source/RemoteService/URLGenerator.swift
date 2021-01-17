//
//  URLGenerator.swift
//  PSAWeatherSDK
//
//  Created by Mohamed Lamine Belfekih on 16/01/2021.
//

import Foundation

/// URLGenerator class allow us to generate a url for our call
class URLGenerator {
    
    /// getURL method allow us to get a URL from the given parameters
    /// - Parameter searchPath: One of our ENUM type SearchPath
    /// - Parameter queryItems: an array of queryItems in the order in weach they appear on the url
    /// - Parameter cityName: the name of the city
    /// - Returns URL
    func getUrl(with searchPath: SearchPath, queryItems: [URLQueryItem]) -> URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.openweathermap.org"
        components.path = searchPath.rawValue
        components.queryItems = queryItems
        return components.url
    }
    
    /// - Returns a QueryItems list needed for get current city weather call
    func currentCityWeatherQueryItems(cityName: String, apiKey: String?) -> [URLQueryItem] {
        return [URLQueryItem(name: "q", value: cityName), URLQueryItem(name: "appid", value: apiKey ?? ""), URLQueryItem(name: "units", value: "metric")]
    }
}

/// SearchPath enum propose for us two cases
/// first case for the weather details
/// second case for the city weather details
enum SearchPath: String {
    case weatherCall = "/data/2.5/onecall"
    case cityCall = "/data/2.5/weather"
}
