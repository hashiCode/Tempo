//
//  DailyWeatherSection.swift
//  Tempo
//
//  Created by Scott Takahashi on 10/05/20.
//  Copyright © 2020 hashiCode. All rights reserved.
//

import SwiftUI

struct DailyWeatherSection: View {
    
    private let dailyWeathers: [DailyWeather]
    
    init(_ dailyWeathers: [DailyWeather]){
        self.dailyWeathers = dailyWeathers
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            SectionText(LocalizedStringKey(Constants.view.kDailyWeather))
                .font(.subheadline)
            ScrollView(.vertical, showsIndicators: false) {
                VStack {
                    ForEach(dailyWeathers) { dailyWeather in
                        DailyWeatherView(dailyWeather)
                    }
                }
            }
        }
    }
}

struct DailyWeatherSection_Previews: PreviewProvider {
    static var previews: some View {
        DailyWeatherSection([DailyWeather(date: "Monday", temperature: 20, minTemperature: 19, maxTemperature: 21, weatherDetail: WeatherDetail(description: "cloud", icon: "cloud.moon")), DailyWeather(date: "Monday", temperature: 20, minTemperature: 19, maxTemperature: 21, weatherDetail: WeatherDetail(description: "cloud", icon: "cloud.moon")), DailyWeather(date: "Monday", temperature: 20, minTemperature: 19, maxTemperature: 21, weatherDetail: WeatherDetail(description: "cloud", icon: "cloud.moon"))])
    }
}
