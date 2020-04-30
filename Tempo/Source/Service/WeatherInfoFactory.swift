//
//  WeatherFactory.swift
//  Tempo
//
//  Created by Scott Takahashi on 05/05/20.
//  Copyright © 2020 hashiCode. All rights reserved.
//

import UIKit


final class WeatherFactory {
    
    func buildWeatherInfo(from response:WeatherJson) -> Weather {
        return Weather(
            latitude: response.lat,
            longitude: response.lon,
            date: "1 maio de 2020",
            isCurrentLocation: true,
            current: self.buildCurrentWeatherInfo(response.current),
            hourly: self.buildHourlyWeatherInfo(response.hourly),
            daily: self.buildDailyWeatherResponse(response.daily)
        )
    }
    
    private func buildHourlyWeatherInfo(_ hourlyWeatherReponseList: [WeatherDataJson]) -> [HourlyWeather] {
        var hourlyArray : [HourlyWeather] = []
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:00"
        for hourlyWeatherResponse in hourlyWeatherReponseList  {
            hourlyArray.append(
                HourlyWeather(
                    date: dateFormatter.string(from: Date(timeIntervalSince1970: TimeInterval(hourlyWeatherResponse.dt))),
                    temperature: hourlyWeatherResponse.temp,
                    weatherDetail: self.buildWeatherDetailInfo(hourlyWeatherResponse.weather.first!)
                )
            )
        }
        return hourlyArray
    }
    
    private func buildDailyWeatherResponse(_ dailyWeatherResponseList: [DailyWeatherJson]) -> [DailyWeather] {
        var dailyArray : [DailyWeather] = []
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        for dailyWeatherResponse in dailyWeatherResponseList {
            dailyArray.append(
                DailyWeather(
                    date: dateFormatter.string(from: Date(timeIntervalSince1970: TimeInterval(dailyWeatherResponse.dt))),
                    temperature: dailyWeatherResponse.temp.day,
                    minTemperature: dailyWeatherResponse.temp.min,
                    maxTemperature: dailyWeatherResponse.temp.max,
                    weatherDetail: self.buildWeatherDetailInfo(dailyWeatherResponse.weather.first!))
            )
        }
        return dailyArray
    }
    
    private func buildCurrentWeatherInfo(_ weatherDataResponse: WeatherDataJson) -> CurrentWeather {
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .short
        
        return CurrentWeather(
            sunrise: dateFormatter.string(from: Date(timeIntervalSince1970: TimeInterval(weatherDataResponse.sunrise))),
            sunset: dateFormatter.string(from: Date(timeIntervalSince1970: TimeInterval(weatherDataResponse.sunset))),
            temperature: weatherDataResponse.temp,
            uvi: weatherDataResponse.uvi,
            clouds: weatherDataResponse.clouds,
            weatherDetail: self.buildWeatherDetailInfo(weatherDataResponse.weather.first!)
        )
    }
    
    private func buildWeatherDetailInfo(_ weatherDetailResponse: WeatherDetailJson) -> WeatherDetail {
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
