//
//  WeatherManager.swift
//  Clima
//
//  Created by Edgar on 6/7/20.
//  Copyright © 2020 Edgar. All rights reserved.
//

import Foundation
import CoreLocation

struct WeatherManager {
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=d4b05eba966fde08926627d34453a687&units=metric"
    var delegate: WeatherManagerDelegate?
    
    func fetchWeather(city: String) {
        let url = "\(weatherURL)&q=\(city)"
        performRequest(with: url)
    }
    
    func fetchWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        let url = "\(weatherURL)&lat=\(latitude)&lon=\(longitude)"
        performRequest(with: url)
    }
    
    private func performRequest(with urlString: String) {
        print(urlString)
        if let finalUrlString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
            if let url = URL(string: finalUrlString) {
                print(url)
                let session = URLSession(configuration: .default)
                let task = session.dataTask(with: url) { (data, response, error) in
                    print("in task")
                    if error != nil {
                        self.delegate?.didFailWithError(error: error!)
                        return
                    }
                    
                    if let safeData = data {
                        if let parsedData = self.parseJSON(safeData) {
                            self.delegate?.didUpdateWeather(self, weather: parsedData)
                        }
                    }
                }
                task.resume()
            }
        }
    }
    
    private func parseJSON(_ weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let id = decodedData.weather[0].id
            let name = decodedData.name
            let temp = decodedData.main.temp
            
            let weather = WeatherModel(conditionId: id, cityName: name, temperature: temp)
            return weather
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
}
