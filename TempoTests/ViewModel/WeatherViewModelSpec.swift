//
//  WeatherViewModelSpec.swift
//  TempoTests
//
//  Created by Scott Takahashi on 14/05/20.
//  Copyright © 2020 hashiCode. All rights reserved.
//

import XCTest
@testable import Tempo

class WeatherViewModelTest: XCTestCase {
    
    var weatherService: WeatherServiceMock!
    var locationService: LocationServiceMock!
    let timeout = 5.0
    
    override func setUpWithError() throws {
        weatherService = WeatherServiceMock()
        locationService = LocationServiceMock()
    }
    
    func testWeatherViewModelGetWeatherInfoOnInit(){
        let weatherViewModel = WeatherViewModel(weatherService: weatherService, locationService: locationService)
        wait(for: [weatherService.expectationGetWeather, locationService.expectationGetCity, locationService.expectationGetCurrentLocation], timeout: timeout)
        RunLoop.main.run(mode: .default, before: .distantPast)
        XCTAssertNotNil(weatherViewModel.weather)
        XCTAssertNotNil(weatherViewModel.cityName)
        XCTAssertNil(weatherViewModel.error)
        XCTAssertTrue(weatherViewModel.hasLoadWeather)
        XCTAssertFalse(weatherViewModel.hasError)
    }
    
    func testWeatherViewModelAssingErrorWhenCannotGetCurrentLocation(){
        locationService.shouldReturnCurrentLocation = false
        let weatherViewModel = WeatherViewModel(weatherService: weatherService, locationService: locationService)
        RunLoop.main.run(mode: .default, before: .distantPast)
        XCTAssertNil(weatherViewModel.weather)
        XCTAssertNil(weatherViewModel.cityName)
        XCTAssertNotNil(weatherViewModel.error)
        XCTAssertFalse(weatherViewModel.hasLoadWeather)
        XCTAssertTrue(weatherViewModel.hasError)
    }
    
    func testWeatherViewModelAssingErrorWhenCannotGetCity(){
        locationService.shouldReturnCity = false
        let weatherViewModel = WeatherViewModel(weatherService: weatherService, locationService: locationService)
        wait(for: [locationService.expectationGetCurrentLocation], timeout: timeout)
        RunLoop.main.run(mode: .default, before: .distantPast)
        XCTAssertNotNil(weatherViewModel.weather)
        XCTAssertNil(weatherViewModel.cityName)
        XCTAssertNotNil(weatherViewModel.error)
        XCTAssertFalse(weatherViewModel.hasLoadWeather)
        XCTAssertTrue(weatherViewModel.hasError)
    }
    
    func testWeatherViewModelAssingErrorWhenCannotGetWeather(){
        weatherService.shouldReturnSuccess = false
        let weatherViewModel = WeatherViewModel(weatherService: weatherService, locationService: locationService)
        wait(for: [locationService.expectationGetCity, locationService.expectationGetCurrentLocation], timeout: timeout)
        RunLoop.main.run(mode: .default, before: .distantPast)
        XCTAssertNil(weatherViewModel.weather)
        XCTAssertNotNil(weatherViewModel.cityName)
        XCTAssertNotNil(weatherViewModel.error)
        XCTAssertFalse(weatherViewModel.hasLoadWeather)
        XCTAssertTrue(weatherViewModel.hasError)
    }

}
