//
//  WeatherViewModel.swift
//  weather
//
//  Created by Joshua Ho on 6/25/23.
//

import Foundation
import Combine


class WeatherViewModel:  ObservableObject {
    @Published var weatherData: WeatherData?
    @Published var weatherFavorites: [WeatherData] = []
    var locationManager = LocationManager()
    
    var cancellable = Set<AnyCancellable>()
    let service = WeatherService()    
    let geoService = GeoCoderService()
    
    @MainActor func getWeather(cityName: String) {
        Task {
            do {
                let geoCoderData: [GeoCoder] = try await geoService.fetchGeoCoderData(cityName: cityName)
                let fetchedWeather: WeatherData = try await service.fetchWeather(lat: geoCoderData[0].lat, lon: geoCoderData[0].lon)
                weatherData = fetchedWeather
            } catch {
                if let error = error as? APIError {
                    print(error.description)
                } else {
                    print(error)
                }
            }
        }
    }
    
    @MainActor func getWeatherByCoords(lat: Double, lon: Double) {
        Task {
            do {
                let fetchedWeather: WeatherData = try await service.fetchWeather(lat: lat, lon: lon)
                weatherData = fetchedWeather
            } catch {
                if let error = error as? APIError {
                    print(error.description)
                } else {
                    print(error)
                }
            }
        }
    }
    
    

}
