//
//  DailyWeather.swift
//  Tempo
//
//  Created by Scott Takahashi on 10/05/20.
//  Copyright © 2020 hashiCode. All rights reserved.
//

import SwiftUI

struct DailyWeatherView: View {
    
    private let dailyWeather: DailyWeather
    private let dayTextWidth: CGFloat = 50.0
    
    init(_ dailyWeather: DailyWeather) {
        self.dailyWeather = dailyWeather
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(dailyWeather.date)
                    .frame(width: dayTextWidth)
                    
                Spacer()
                Image(systemName: dailyWeather.weatherDetail.icon)
                Spacer()
                HStack {
                    Text("\(dailyWeather.maxTemperature)")
                        .foregroundColor(Color(UIColor.systemRed))
                    Text("/")
                    Text("\(dailyWeather.minTemperature)")
                        .foregroundColor(Color(UIColor.systemTeal))
                }
            }
        }
        .padding(10)
    }
}

struct DailyWeatherView_Previews: PreviewProvider {
    static var previews: some View {
        DailyWeatherView(DailyWeather(date: "Monday", temperature: 20, minTemperature: 19, maxTemperature: 21, weatherDetail: WeatherDetail(description: "cloud", icon: "cloud.moon")))
    }
}
