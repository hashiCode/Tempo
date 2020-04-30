//
//  CurrentWeather.swift
//  Tempo
//
//  Created by Scott Takahashi on 10/05/20.
//  Copyright © 2020 hashiCode. All rights reserved.
//

import SwiftUI

struct CurrentWeatherSection: View {
    
    private let currentWeather: CurrentWeather
    private let hoursWidth : CGFloat = 50.0
    
    init(_ currentWeather: CurrentWeather) {
        self.currentWeather = currentWeather
    }
    
    var body: some View {
        HStack(spacing: 20) {
            VStack(alignment: .center, spacing: 1) {
                HStack {
                    Image(systemName: currentWeather.weatherDetail.icon)
                        .imageScale(.large)
                    Text(currentWeather.weatherDetail.description)
                        .fontWeight(.medium)
                }
                Text("\(currentWeather.temperature)")
                    .bold()
                    .font(.system(size: 100))
            }
            VStack(alignment: .leading) {
                HStack {
                    Image(systemName: "sunrise")
                    Text(currentWeather.sunrise)
                        .frame(width: hoursWidth)
                    
                   
                    Image(systemName: "sun.min.fill")
                    Text("UVI: \(currentWeather.uvi)")
                }
                
                HStack {
                    Image(systemName: "sunset")
                    Text(currentWeather.sunset)
                        .frame(width: hoursWidth)
                    
                    Image(systemName: "smoke.fill")
                    Text("\(currentWeather.clouds) %")
                }
            }
        }
    }
}


struct CurrentWeatherSection_Previews: PreviewProvider {
    static var previews: some View {
        CurrentWeatherSection(CurrentWeather(sunrise: "6:00", sunset: "18:00", temperature: 10, uvi: "6.01", clouds: 20, weatherDetail: WeatherDetail(description: "cloud", icon: "cloud.moon")))
    }
}
