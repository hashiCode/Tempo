//
//  LocationServiceMock.swift
//  TempoTests
//
//  Created by Scott Takahashi on 14/05/20.
//  Copyright © 2020 hashiCode. All rights reserved.
//

@testable import Tempo
import Foundation
import Combine
import CoreLocation
import XCTest

class LocationServiceMock: LocationService {
    
    var shouldReturnCurrentLocation = true
    var shouldReturnCity = true
    
    let errorMsg = "Unable to retrieve location"
    
    public private(set) var startLocationUpdateWasCalled = false
    public private(set) var stopLocationUpdateWasCalled = false
    
    var expectationGetCurrentLocation: XCTestExpectation = XCTestExpectation(description: "getCurrentLocation")
    var expectationGetCity: XCTestExpectation = XCTestExpectation(description: "getCity")
    
    func getCurrentLocation() -> AnyPublisher<CLLocation, WeatherError> {
        return Future<CLLocation, WeatherError> { promise in
            if self.shouldReturnCurrentLocation {
                self.expectationGetCurrentLocation.fulfill()
                promise(.success(CLLocation.init(latitude: CLLocationDegrees(), longitude: CLLocationDegrees())))
            } else {
                promise(.failure(WeatherError.location(self.errorMsg)))
            }
        }.eraseToAnyPublisher()
    }
    
    func getCity(from location: CLLocation) -> AnyPublisher<String, WeatherError> {
        return Future<String, WeatherError> { promise in
            if self.shouldReturnCity {
                self.expectationGetCity.fulfill()
                promise(.success("Santos"))
            }
            else {
                promise(.failure(WeatherError.location(self.errorMsg)))
            }
        }.eraseToAnyPublisher()
    }
    
    func startLocationUpdate() {
        self.startLocationUpdateWasCalled = true
    }
    
    func stopLocationUpdate() {
        self.stopLocationUpdateWasCalled = true
    }
    

}
