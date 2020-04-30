//
//  Constants.swift
//  Tempo
//
//  Created by Scott Takahashi on 14/05/20.
//  Copyright © 2020 hashiCode. All rights reserved.
//

import UIKit

struct Constants {
    
    struct view {
        static let kSpinnerLoading = "spinner.loading"
        static let kHourlyWeather = "hourlyWeather.title"
        static let kDailyWeather = "dailyWeather.title"
        
        static let kAlertTitle = "alert.error.title"
        static let kAlertTryAgainButton = "alert.button.tryAgain"
    }
    
    struct error {
        static let kLocationError = "locationErrorText"
    }
    
    struct api {
        static let kScheme = "https"
        static let kBaseURL = "api.openweathermap.org"
        static let kPath = "/data/2.5/onecall"
        static let kApiKeyFile = "ApiKey"
        static let kApiKey = "openWeatherApiKey"
        
        static let kLatitude = "lat"
        static let kLongitude = "lon"
        static let kAppId = "appid"
        static let kUnits = "units"
        static let kMetrics = "metric"
        static let kLanguage = "lang"
    }
   
}

