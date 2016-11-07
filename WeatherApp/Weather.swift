//
//  Weather.swift
//  WeatherApp
//
//  Created by Ömer Koçbil on 7.11.2016.
//  Copyright © 2016 Ömer Koçbil. All rights reserved.
//

import Foundation

struct Weather {
    
    let temp: Double
    let description: String
    
    init(temp: Double, description: String){
        self.temp = temp
        self.description = description
    }
    
}
