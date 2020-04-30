//
//  WeatherFactory.swift
//  Tempo
//
//  Created by Scott Takahashi on 10/05/20.
//  Copyright © 2020 hashiCode. All rights reserved.
//

import Foundation


final class WeatherFactory {
    
    func buildWeatherModel(from response:WeatherJSON) -> WeatherModel {
        return WeatherModel(
            current: self.buildCurrentWeather(response.current),
            hourly: self.buildHourlyWeather(response.hourly),
            daily: self.buildDailyWeather(response.daily)
        )
    }
    
    private func buildHourlyWeather(_ hourlyWeatherReponseList: [Hourly]) -> [HourlyWeather] {
        var hourlyArray : [HourlyWeather] = []
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:00"
        for hourlyWeatherResponse in hourlyWeatherReponseList  {
            hourlyArray.append(
                HourlyWeather(
                    date: dateFormatter.string(from: Date(timeIntervalSince1970: TimeInterval(hourlyWeatherResponse.dt))),
                    temperature: Int(hourlyWeatherResponse.temp.rounded()),
                    weatherDetail: self.buildWeatherDetailInfo(hourlyWeatherResponse.weather.first!)
                )
            )
        }
        return hourlyArray
    }
    
    private func buildDailyWeather(_ dailyWeatherResponseList: [Daily]) -> [DailyWeather] {
        var dailyArray : [DailyWeather] = []
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E"
        for dailyWeatherResponse in dailyWeatherResponseList {
            dailyArray.append(
                DailyWeather(
                    date: dateFormatter.string(from: Date(timeIntervalSince1970: TimeInterval(dailyWeatherResponse.dt))),
                    temperature: Int(dailyWeatherResponse.temp.day.rounded()),
                    minTemperature: Int(dailyWeatherResponse.temp.min.rounded()),
                    maxTemperature: Int(dailyWeatherResponse.temp.max.rounded()),
                    weatherDetail: self.buildWeatherDetailInfo(dailyWeatherResponse.weather.first!))
            )
        }
        return dailyArray
    }
    
    private func buildCurrentWeather(_ weatherDataResponse: Current) -> CurrentWeather {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        
        return CurrentWeather(
            sunrise: dateFormatter.string(from: Date(timeIntervalSince1970: TimeInterval(weatherDataResponse.sunrise))),
            sunset: dateFormatter.string(from: Date(timeIntervalSince1970: TimeInterval(weatherDataResponse.sunset))),
            temperature: Int(weatherDataResponse.temp.rounded()),
            uvi: String(format: "%.2f", weatherDataResponse.uvi),
            clouds: weatherDataResponse.clouds,
            weatherDetail: self.buildWeatherDetailInfo(weatherDataResponse.weather.first!)
        )
    }
    
    private func buildWeatherDetailInfo(_ weatherDetailResponse: Weather) -> WeatherDetail {
        return WeatherDetail(
            description: weatherDetailResponse.description, icon: self.getIconName(weatherDetailResponse.icon))
    }
    
    private func getIconName(_ iconId: String) -> String {
        switch iconId {
        case "01d":
            return "sun.max"
        case "01n":
            return "moon"
        case "02d":
            return "cloud.sun"
        case "02n":
            return "cloud.moon"
        case "03d", "03n":
            return "cloud"
        case "04d", "04n":
            return "smoke"
        case "09d", "09n":
            return "cloud.rain"
        case "10d":
            return "cloud.sun.rain"
        case "10n":
            return "cloud.moon.rain"
        case "11d", "11n":
            return "cloud.bolt"
        case "13d", "13n":
            return "snow"
        case "50d", "50n":
            return "cloud.fog"
        default:
            fatalError("Unknow icon")
        }
    }

}
