//
//  WeatherService.swift
//  Tempo
//
//  Created by Scott Takahashi on 10/05/20.
//  Copyright © 2020 hashiCode. All rights reserved.
//

import Foundation
import Combine
import CoreLocation

protocol WeatherService {
    
    func getWeatherFromCoordinate(coordinate: Coordinate) -> AnyPublisher<WeatherModel, WeatherError>
    
}

class WeatherServiceNetwork: WeatherService {
    
    private let apiKey : String
    
    init(){
        guard let path = Bundle.main.path(forResource: Constants.api.kApiKeyFile, ofType: "plist"),
            let dictionary = NSDictionary(contentsOfFile: path),
            let apiKey = dictionary[Constants.api.kApiKey] as? String else {
            fatalError("ApiKey not found")
        }
        self.apiKey = apiKey
    }
    
    func getWeatherFromCoordinate(coordinate: Coordinate) -> AnyPublisher<WeatherModel, WeatherError> {
        let url = self.buildURL(coordinate: coordinate)
        return URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { result -> WeatherModel in
                let weatherResponse = try JSONDecoder().decode(WeatherJSON.self, from: result.data)
                return WeatherFactory().buildWeatherModel(from: weatherResponse)
            }
            .mapError { error -> WeatherError in
                return WeatherError.api(error.localizedDescription)
            }
            .eraseToAnyPublisher()
    }
    
    private func buildURL(coordinate: Coordinate) -> URL {
        var urlComponent = URLComponents()
        urlComponent.scheme = Constants.api.kScheme
        urlComponent.host = Constants.api.kBaseURL
        urlComponent.path = Constants.api.kPath
        let language = Bundle.main.preferredLocalizations.first!.components(separatedBy: "-")[0]
        urlComponent.queryItems = [
            URLQueryItem.init(name: Constants.api.kLatitude, value: "\(coordinate.latitude)"),
            URLQueryItem.init(name: Constants.api.kLongitude, value: "\(coordinate.longitude)"),
            URLQueryItem.init(name: Constants.api.kAppId, value: self.apiKey),
            URLQueryItem.init(name: Constants.api.kUnits, value: Constants.api.kMetrics),
            URLQueryItem.init(name: Constants.api.kLanguage, value: language)
        ]
        guard let url = urlComponent.url else {
            fatalError("Cannot create url using: lat=\(coordinate.latitude), lon=\(coordinate.longitude)")
        }
        return url
    }
}
