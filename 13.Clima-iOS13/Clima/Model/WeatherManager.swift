//
//  WeatherManager.swift
//  Clima
//
//  Created by Rafael Benjamin on 02/05/22.
//  Copyright © 2022 App Brewery. All rights reserved.
//

import Foundation
import CoreLocation

protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
    func didFailWithError(error: Error)
}

struct WeatherManager {
    
    private var apiKey: String {
        get {
            guard let filePath = Bundle.main.path(forResource: "Keys", ofType: "plist") else {
                fatalError("Couldn't find file 'Keys.plist'.")
            }
            let plist = NSDictionary(contentsOfFile: filePath)
            guard let value = plist?.object(forKey: "OpenWeatherApiKey") as? String else {
                fatalError("Couldn't find key 'OpenWeatherApiKey' in 'Keys.plist'.")
            }
            if (value.starts(with: "_")) {
                fatalError("Register for a OpenWeather developer account and get an API key at https://openweathermap.org/appid.")
            }
            return value
        }
    }
    
    private var urlString: String {
        return "https://api.openweathermap.org/data/2.5/weather?APPID=\(self.apiKey)&units=metric"
    }
    
    var delegate: WeatherManagerDelegate?
    
    func fetchWeather(cityName: String) {
        let urlString = "\(urlString)&q=\(cityName)"
        print(urlString)
        performRequest(with: urlString)
    }
    
    func fetchWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        let urlString = "\(urlString)&lat=\(latitude)&lon=\(longitude)"
        print(urlString)
        performRequest(with: urlString)
    }
    
    func performRequest(with urlString: String) {
        //1.Create a URL
        if let url = URL(string: urlString) {
            //2.Create a URL Session
            let session = URLSession(configuration: .default)
            
            //3. Give the Session a task
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                
                if let safeData = data {
                    if let weather = self.parseJSON(safeData){
                        delegate?.didUpdateWeather(self, weather: weather)
                    }
                }
            }
            
            //4.Start the task
            task.resume()
        }
        
    }
    
    func parseJSON(_ weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let id = decodedData.weather[0].id
            let temp = decodedData.main.temp
            let name = decodedData.name
            
            let weather = WeatherModel(conditionId: id, cityName: name, temperature: temp)
            //            print(weather.temperatureString)
            //            print(weather.conditionName)
            return weather
        } catch {
            self.delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
}

