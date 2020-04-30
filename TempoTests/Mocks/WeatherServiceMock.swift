//
//  WeatherServiceMock.swift
//  TempoTests
//
//  Created by Scott Takahashi on 14/05/20.
//  Copyright © 2020 hashiCode. All rights reserved.
//

@testable import Tempo
import Combine
import Foundation
import XCTest

class WeatherServiceMock: WeatherService {
    
    var shouldReturnSuccess = true
    var expectationGetWeather: XCTestExpectation = XCTestExpectation(description: "getWEather")
    
    func getWeatherFromCoordinate(coordinate: Coordinate) -> AnyPublisher<WeatherModel, WeatherError> {
        return Future<WeatherModel, WeatherError> { promise in
            if self.shouldReturnSuccess {
                do {
                    guard let path = Bundle(for: type(of: self)).url(forResource: "weather", withExtension: "json") else { fatalError("weather.json not found") }
                    let data = try Data(contentsOf: path)
                    let weather = try JSONDecoder().decode(WeatherJSON.self, from: data)
                    self.expectationGetWeather.fulfill()
                    promise(.success(WeatherFactory().buildWeatherModel(from: weather)))
                    
                } catch _ {
                    promise(.failure(WeatherError.api("Api error")))
                }
            } else {
                promise(.failure(WeatherError.api("Api error")))
            }
            
        }.eraseToAnyPublisher()
    }

}
