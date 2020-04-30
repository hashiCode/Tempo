//
//  HourlyWeatherSection.swift
//  Tempo
//
//  Created by Scott Takahashi on 10/05/20.
//  Copyright © 2020 hashiCode. All rights reserved.
//

import SwiftUI

struct HourlyWeatherSection: View {

    private let hourlyWeathers: [HourlyWeather]
    
    init(_ hourlyWeathers: [HourlyWeather]){
        self.hourlyWeathers = hourlyWeathers
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            SectionText(LocalizedStringKey(Constants.view.kHourlyWeather))
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(hourlyWeathers) { hourlyWeather in
                        HourlyWeatherView(hourlyWeather)
                    }
                }
            }
        }
    }
}

struct HourlyWeatherSection_Previews: PreviewProvider {
    static var previews: some View {
        HourlyWeatherSection([HourlyWeather(date: "21:00", temperature: 20, weatherDetail: WeatherDetail(description: "cloud", icon: "cloud.moon")), HourlyWeather(date: "22:00", temperature: 20, weatherDetail: WeatherDetail(description: "cloud", icon: "cloud.moon")), HourlyWeather(date: "23:00", temperature: 20, weatherDetail: WeatherDetail(description: "cloud", icon: "cloud.moon"))])
    }
}
