//
//  LocationService.swift
//  Tempo
//
//  Created by Scott Takahashi on 10/05/20.
//  Copyright © 2020 hashiCode. All rights reserved.
//

import UIKit
import CoreLocation
import Combine

protocol LocationService {
    
    func getCurrentLocation() -> AnyPublisher<CLLocation, WeatherError>
    
    func getCity(from location:CLLocation) -> AnyPublisher<String, WeatherError>
    
    func startLocationUpdate()
    
    func stopLocationUpdate()

}

class CoreLocationService : NSObject, LocationService {
    
    
    private let locationManager = CLLocationManager()
    private let geocoder = CLGeocoder()
    
    var objectWillChange : PassthroughSubject<CLLocation, WeatherError>
    var publisher: AnyPublisher<CLLocation, WeatherError>
    
    override init() {
        self.objectWillChange = PassthroughSubject<CLLocation, WeatherError>()
        self.publisher = AnyPublisher<CLLocation, WeatherError>(objectWillChange)
        super.init()
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        
        self.locationManager.requestWhenInUseAuthorization()
    }
    
    
    func getCurrentLocation() -> AnyPublisher<CLLocation, WeatherError> {
        return self.publisher
    }
    
    func getCity(from location: CLLocation) -> AnyPublisher<String, WeatherError> {
        return Future<String, WeatherError> { promise in
            self.geocoder.reverseGeocodeLocation(location) { (placemarks, error) in
                if let results = placemarks {
                    let placemark = results[0]
                    promise(.success(placemark.locality!))
                } else {
                    promise(.failure(WeatherError.location(NSLocalizedString(Constants.error.kLocationError, comment: ""))))
                }
            }
        }.eraseToAnyPublisher()
    }
    
    func startLocationUpdate() {
        self.locationManager.startUpdatingLocation()
    }
    
    func stopLocationUpdate() {
        self.locationManager.stopUpdatingLocation()
    }
    

}

// MARK: CLLocationManagerDelegate
extension CoreLocationService: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let currentLocation: CLLocation = locations.last else {
            self.sendUnableToRetrieveLocationError()
            return
        }
        //update the publisher. Current location will pass to the subscribers
        objectWillChange.send(currentLocation)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        self.sendUnableToRetrieveLocationError()
    }
    
    
}

// MARK: private functions
extension CoreLocationService {
    
    private func sendUnableToRetrieveLocationError(){
        objectWillChange.send(completion: Subscribers.Completion.failure(WeatherError.location(NSLocalizedString(Constants.error.kLocationError, comment: ""))))
    }
    
}
