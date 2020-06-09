//
//  WeatherManagerDelegate.swift
//  Clima
//
//  Created by Edgar on 6/8/20.
//  Copyright © 2020 Edgar. All rights reserved.
//

protocol WeatherManagerDelegate {
//    func didUpdateWeather(weather: WeatherModel)
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
    func didFailWithError(error: Error)
}
