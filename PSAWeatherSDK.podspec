Pod::Spec.new do |spec|

  spec.name         = "PSAWeatherSDK"
  spec.version      = "0.1"
  spec.summary      = "PSAWeatherSDK is a weather library implemented on swift"
  spec.description  = <<-DESC
			PSAWeatherSDK allows you to add Cities weather and to check weather details
                   DESC
  spec.homepage     = "https://github.com/MedAmineWinners/PSAWeatherSDK"
  spec.license      = { :type => "MIT", :file => "LICENSE" }
  spec.author       = { "Amine Belfekih" => "mohamedamine.belfkih@esprit.tn" }
  spec.swift_version = "5.0"
  spec.ios.deployment_target = "11.0"
  spec.source       = { :git => "https://github.com/MedAmineWinners/PSAWeatherSDK.git", :tag => "#{spec.version}" }

  spec.requires_arc = true
  spec.source_files  = "PSAWeatherSDK/**/*.{h,m,swift,xcdatamodeld}"
  spec.resources = "PSAWeatherSDK/**/*.{xcdatamodeld}"
  spec.framework = "CoreData"
  
end
    