//
//  ApiError.swift
//  PSAWeatherSDK
//
//  Created by Mohamed Lamine Belfekih on 18/01/2021.
//

import Foundation

struct ApiError : Codable {
    let cod : String
    let message : String
}
