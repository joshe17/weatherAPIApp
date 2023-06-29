//
//  WeatherResponse.swift
//  weather
//
//  Created by Joshua Ho on 6/25/23.
//

import Foundation

struct WeatherData: Identifiable, Codable {
    let coord: Coord
    let weather: [Weather]
    let mainData: MainData
    let timezone: Int
    let name: String
    let id: Int
   
    private enum CodingKeys: String, CodingKey {
        case coord = "coord"
        case weather = "weather"
        case mainData = "main"
        case timezone = "timezone"
        case name = "name"
        case id = "id"
    }
    
    func formatTime() -> String {
        let d = Date()
        var f = Date.FormatStyle(time: .shortened)
        f.timeZone = TimeZone(secondsFromGMT: self.timezone)!
        return d.formatted(f)
    }
}

extension WeatherData: Equatable {
    static func == (lhs: WeatherData, rhs: WeatherData) -> Bool {
        return lhs.id == rhs.id
    }
}



struct Coord: Codable {
    let lat: Double
    let lon: Double
    
    private enum CodingKeys: String, CodingKey {
        case lat = "lat"
        case lon = "lon"
    }
}

struct Weather: Codable  {
    let main: String
    let description: String
    let icon: String
    
    private enum CodingKeys: String, CodingKey {
        case main = "main"
        case description = "description"
        case icon = "icon"
    }
}

//case main in api call

struct MainData: Codable {
    let temp: Double
    let minTemp: Double
    let maxTemp: Double
    let humidity: Int
    let feelsLike: Double
    
    private enum CodingKeys: String, CodingKey {
        case temp = "temp"
        case minTemp = "temp_min"
        case maxTemp = "temp_max"
        case humidity = "humidity"
        case feelsLike = "feels_like"
    }
}
