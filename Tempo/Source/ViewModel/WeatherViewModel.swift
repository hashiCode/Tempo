//
//  WeatherViewModel.swift
//  Tempo
//
//  Created by Scott Takahashi on 10/05/20.
//  Copyright © 2020 hashiCode. All rights reserved.
//

import Foundation
import Combine

class WeatherViewModel: ObservableObject {
    
    @Published private(set) var weather: WeatherModel?
    @Published private(set) var cityName: String?
    @Published private(set) var error: WeatherError?
    @Published var hasLoadWeather = false
    @Published var hasError = false
    
    private let weatherService: WeatherService
    private let locationService: LocationService
    private var anyCancelable = Set<AnyCancellable>()
    
    init(weatherService: WeatherService = WeatherServiceNetwork(), locationService: LocationService = CoreLocationService()){
        self.weatherService = weatherService
        self.locationService = locationService
        self.getWeatherFromCurrentLocation()
    }
    
    func getWeatherFromCurrentLocation() {
        self.weather = nil
        self.cityName = nil
        self.error = nil
        self.hasLoadWeather = false
        self.hasError = false
        self.locationService.startLocationUpdate()
        self.locationService.getCurrentLocation()
            .sink(receiveCompletion: { (completition) in
                
                self.handleCompletition(completition)
            }) { (location) in
                self.locationService.stopLocationUpdate()
                let coordinate = location.coordinate
                self.weatherService.getWeatherFromCoordinate(coordinate: Coordinate(latitude: coordinate.latitude, longitude: coordinate.longitude))
                    .receive(on: DispatchQueue.main)
                    .sink(receiveCompletion: { completition in
                        self.handleCompletition(completition)
                    }, receiveValue: { weather in
                        self.weather = weather
                        self.hasLoadWeather = self.cityName != nil
                    }).store(in: &self.anyCancelable)
                
                self.locationService.getCity(from: location)
                    .receive(on: DispatchQueue.main)
                    .sink(receiveCompletion: { completition in
                        self.handleCompletition(completition)
                    }, receiveValue: { cityName in
                        self.cityName = cityName
                        self.hasLoadWeather = self.weather != nil
                    }).store(in: &self.anyCancelable)
        }.store(in: &self.anyCancelable)
    }
    
    fileprivate func handleCompletition(_ completition: Subscribers.Completion<WeatherError>) {
        switch completition {
        case .failure(let error):
            self.error = error
            self.hasLoadWeather = false
            self.hasError = true
            break;
        case .finished:
            break;
        }
    }
    
}
