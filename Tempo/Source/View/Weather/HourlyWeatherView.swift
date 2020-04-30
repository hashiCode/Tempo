//
//  HourlyWeather.swift
//  Tempo
//
//  Created by Scott Takahashi on 10/05/20.
//  Copyright © 2020 hashiCode. All rights reserved.
//

import SwiftUI

struct HourlyWeatherView: View {
    
    private let hourlyWeather: HourlyWeather
    
    init(_ hourlyWeather: HourlyWeather){
        self.hourlyWeather = hourlyWeather
    }
    
    var body: some View {
        VStack(alignment: .center) {
            Text(hourlyWeather.date)
                .font(.subheadline)
                .frame(minWidth: 41)
            Image(systemName: hourlyWeather.weatherDetail.icon)
            Text("\(hourlyWeather.temperature)")
        }
        .padding(10)
    }
}

struct HourlyWeatherView_Previews: PreviewProvider {
    static var previews: some View {
        HourlyWeatherView(HourlyWeather(date: "21:00", temperature: 20, weatherDetail: WeatherDetail(description: "cloud", icon: "cloud.moon")))
    }
}
