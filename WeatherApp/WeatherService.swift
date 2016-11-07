//
//  WeatherService.swift
//  WeatherApp
//
//  Created by Ömer Koçbil on 6.11.2016.
//  Copyright © 2016 Ömer Koçbil. All rights reserved.
//

import Foundation

protocol WeatherServiceDelegate {
    func setWeather(weather: Weather)
}

class WeatherService{
    
    var delegate: WeatherServiceDelegate?
    
    func getWeather(city: String) {
        let path = "http://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=f0e156ab39c92234506b578fb36bf468"
        let url = NSURL(string: path)
        let session = URLSession.shared
        let task = session.dataTask(with: url as! URL) { (data: Data?, response: URLResponse?, error: Error?) -> Void in
            
            let json = JSON(data: data!)
            let lon = json["coord"]["lon"].double
            let lat = json["coord"]["lat"].double
            let temp = json["main"]["temp"].double! - 273.15
            let description = json["weather"][0]["description"].string!
            
            print("lon: \(lon!) lat: \(lat!) temp: \(temp)")
        
            let weather = Weather(temp: temp, description: description)
            
            if self.delegate != nil {
                self.delegate?.setWeather(weather: weather)
            }
        }
        
        task.resume()
    }
    
}
