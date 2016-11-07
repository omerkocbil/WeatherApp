//
//  ViewController.swift
//  WeatherApp
//
//  Created by Ömer Koçbil on 5.11.2016.
//  Copyright © 2016 Ömer Koçbil. All rights reserved.
//

import UIKit

class ViewController: UIViewController, WeatherServiceDelegate {

    let weatherService = WeatherService()
    
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var descriptionlabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    
    @IBAction func setCityButtonClick(_ sender: Any) {
        // openCityAlert()
        openCityAlertWithTextField()
    }

    @IBAction func getWeatherButtonClick(_ sender: Any) {
        self.weatherService.getWeather(city: self.cityLabel.text!)
    }
    
    // Creating messageDialog with cancel and ok action
    func openCityAlert(){
        // Create alert
        let alert = UIAlertController(title: "City", message: "Enter City Name", preferredStyle: UIAlertControllerStyle.alert)
        
        // Create cancel action
        let cancel = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil)
        
        // Create ok action
        let ok = UIAlertAction(title: "Ok", style: UIAlertActionStyle.default) {(action: UIAlertAction) -> Void in print("Ok")
        }
        
        alert.addAction(cancel)
        alert.addAction(ok)
        
        // Present alert
        self.present(alert, animated: true, completion: nil)
    }
    
    
    // Creating messageDialog with cancel, ok action and textfield
    func openCityAlertWithTextField(){
        // Create alert
        let alert = UIAlertController(title: "City", message: "Enter City Name", preferredStyle: UIAlertControllerStyle.alert)
        
        // Create cancel action
        let cancel = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil)
        
        // Create ok action
        let ok = UIAlertAction(title: "Ok", style: UIAlertActionStyle.default) {(action: UIAlertAction) -> Void in print("Ok")
            let textField = alert.textFields?[0] // call if alert has textField
            self.cityLabel.text = textField?.text!
        }
        
        // Create textfeld into alert
        alert.addTextField{(textField: UITextField) -> Void in
            textField.placeholder = "City Name"
        }
        
        alert.addAction(cancel)
        alert.addAction(ok)
        
        // Present alert
        self.present(alert, animated: true, completion: nil)
    }
    
    /*
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
            
            self.descriptionlabel.text = "The weather is \(description)"
            self.tempLabel.text = "Temperature is \(String(Int(temp))) C"
        }
        
        task.resume()
    }
    */
    
    // WeatherServiceDelegate method
    func setWeather(weather: Weather) {
        self.descriptionlabel.text = "The weather is \(weather.description)"
        self.tempLabel.text = "Temperature is \(String(Int(weather.temp))) C"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.weatherService.delegate = self 
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

