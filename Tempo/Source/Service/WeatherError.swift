//
//  TempoError.swift
//  Tempo
//
//  Created by Scott Takahashi on 10/05/20.
//  Copyright © 2020 hashiCode. All rights reserved.
//

import UIKit

class WeatherError: LocalizedError {

    let description: String
    
    private init(description: String){
        self.description = description
    }
    
    static func api(_ errorDescription: String) -> WeatherError {
        return WeatherError(description: errorDescription)
    }
    
    static func location(_ errorDescription: String) -> WeatherError {
        return WeatherError(description: errorDescription)
    }
    
    //MARK: LocalizedError
    var localizedDescription: String {
        return self.description
    }
}


