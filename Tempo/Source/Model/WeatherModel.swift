//
//  WeatherInfo.swift
//  Tempo
//
//  Created by Scott Takahashi on 10/05/20.
//  Copyright © 2020 hashiCode. All rights reserved.
//

import Foundation

struct WeatherModel {
//    let latitude, longitude: Double
//    let isCurrentLocation: Bool
    let current: CurrentWeather
    let hourly: [HourlyWeather]
    let daily: [DailyWeather]
}

struct CurrentWeather {
    let sunrise, sunset: String
    let temperature: Int
    let uvi: String
    let clouds: Int
    let weatherDetail: WeatherDetail
}

struct HourlyWeather: Identifiable {
    let id = UUID()
    
    let date: String
    let temperature: Int
    let weatherDetail: WeatherDetail
}

struct DailyWeather: Identifiable {
    let id = UUID()
    
    let date: String
    let temperature: Int
    let minTemperature, maxTemperature: Int
    let weatherDetail: WeatherDetail
}

struct WeatherDetail {
    let description: String
    let icon: String
}
