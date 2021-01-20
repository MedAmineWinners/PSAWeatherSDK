# PSAWeatherSDK
## Description
PSAWeatherSDK is a library implented in Swift using a clean architecture and allowing users to:
- add a city weather to his app
- to get until 20 saved cities weather
- to get daily and hourly forcast details for each saved city.

## Installation
### CocoaPods
CocoaPods is a dependency manager for Cocoa projects. For usage and installation instructions, visit their website. To integrate PSAWeatherSDK into your Xcode project using CocoaPods, specify it in your Podfile:

```ruby
pod 'PSAWeatherSDK', '~> 0.0'
```

## How to use 
### Configuration 
PSAWeatherSDK is base on openweathermap api, an **apiKey is mandatory** to configure PSAWeatherSDK, so create an account on openweathermap and get an apiKey and configure your SDK doing the following 

```swift
PSAWeatherSDK.shared.configure((with: "your apikey")
```
### usage 
once the SDK configured you can start using it, all the functionnalities are in **PSAWeatherSDKProtocols**
you need to :
- conform your ViewController to **PSAWeatherSDKDelegate**
```swift
class ViewController: PSAWeatherSDKDelegate 
```

- call the needed method, example: 
```swift
PSAWeatherSDK.shared.addCity(with: cityName)
```
*the result of your call will be triggered on PSAWeatherSDKDelegate methods*

## Demo App
you can check [here](https://github.com/MedAmineWinners/PSAWeatherAPP) our PSAWeatherApp to check the SDK use
