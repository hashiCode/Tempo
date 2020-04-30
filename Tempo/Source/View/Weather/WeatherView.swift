//
//  WeatherView.swift
//  Tempo
//
//  Created by Scott Takahashi on 10/05/20.
//  Copyright © 2020 hashiCode. All rights reserved.
//

import SwiftUI

struct WeatherView: View {
    
    @ObservedObject
    var weatherViewModel: WeatherViewModel
    
    init(weatherViewModel: WeatherViewModel){
        self.weatherViewModel = weatherViewModel
        
    }
    
    var body: some View {
        let hasLoadWeather = self.weatherViewModel.hasLoadWeather
        return AnyView(
            ZStack(alignment: .center) {
                
                contentView
                    .padding(10)
                
                if !hasLoadWeather {
                    Spinner()
                }
                
            }
        ).alert(isPresented: self.$weatherViewModel.hasError) { () -> Alert in
            Alert(title: Text(LocalizedStringKey(Constants.view.kAlertTitle)), message: Text(self.weatherViewModel.error!.localizedDescription), dismissButton: .default(Text(LocalizedStringKey(Constants.view.kAlertTryAgainButton)), action: {
                    self.weatherViewModel.getWeatherFromCurrentLocation()
            }))
        }
        
    }
    
    private var contentView: some View {
        if self.weatherViewModel.hasLoadWeather {
            guard let weather = weatherViewModel.weather, let cityName = weatherViewModel.cityName else {
                fatalError("Unexpected state")
            }
            
            return AnyView(VStack(spacing: 32) {
                LocationSection(cityName)
                
                CurrentWeatherSection(weather.current)
                
                HourlyWeatherSection(weather.hourly)
                        .padding(EdgeInsets.init(top: 0, leading: 10, bottom: 0, trailing: 10))
                DailyWeatherSection(weather.daily)
                        .padding(EdgeInsets.init(top: 0, leading: 10, bottom: 0, trailing: 10))
            })
        }
        return AnyView(EmptyView())
    }
}


#if DEBUG
//class WeatherViewModelMock: WeatherViewModel {
//
//    init(){
//
//        let weatherDetail = WeatherDetail(description: "cloud", icon: "cloud.moon")
//        let hourlyWeather = HourlyWeather(date: "1:00", temperature: 20, weatherDetail: weatherDetail)
//        let dailyWeather = DailyWeather(date: "Mon", temperature: 20, minTemperature: 19, maxTemperature: 21, weatherDetail: weatherDetail)
//        self.cityName = "Santos"
//        self.weather = WeatherModel(
//            current: CurrentWeather(
//                sunrise: "6:34",
//                sunset: "17:31",
//                temperature: 22,
//                uvi: "6.01",
//                clouds: 20,
//                weatherDetail: weatherDetail
//            ),
//            hourly: [
//                hourlyWeather,
//                hourlyWeather,
//                hourlyWeather,
//                hourlyWeather,
//                hourlyWeather
//            ],
//            daily: [
//                dailyWeather,
//                dailyWeather,
//                dailyWeather,
//                dailyWeather,
//                dailyWeather,
//                dailyWeather,
//            ])
//        super.init()
//    }
//}
//
//struct WeatherView_Previews: PreviewProvider {
//    static var previews: some View {
//        WeatherView(weatherViewModel: WeatherViewModelMock())
//    }
//}

#endif
