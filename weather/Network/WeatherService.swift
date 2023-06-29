//
//  WeatherService.swift
//  weather
//
//  Created by Joshua Ho on 6/25/23.
//

import Foundation
import Combine
// api link
// api.openweathermap.org

// api call
// https://api.openweathermap.org/data/2.5/weather?lat={lat}&lon={lon}&appid={API key}

// api key
// 84247281be424403b8aed106b3b76e11

enum APIError: Error {
    case invalidUrl
    case invalidResponse
    case emptyData
    case serviceUnavailable
    case decodingError
                    
    var description: String {
        switch self {
        case .invalidUrl:
            return "invalid URL"
        case .invalidResponse:
            return "invalid response"
        case .emptyData:
            return "empty data"
        case .serviceUnavailable:
            return "service unavailable"
        case .decodingError:
            return "decoding error"
        }
    }
}

class WeatherService {
    var cancellable = Set<AnyCancellable>()
    var apiKey = "84247281be424403b8aed106b3b76e11"
    
    //NOT SURE IF I SHOULD BE RETURNING AN ARRAY HERE
    func fetchWeather(lat: Double, lon: Double) async throws -> WeatherData {
        let urlString = "https://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(lon)&appid=\(apiKey)&units=imperial"
//        let urlString = "https://api.openweathermap.org/data/2.5/weather?q=\(cityName.replacingOccurrences(of: " ", with: "+"))&appid=\(apiKey)&units=imperial"
        guard let url = URL(string: urlString) else { throw APIError.invalidUrl }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let resp = response as? HTTPURLResponse, resp.statusCode == 200 else { throw APIError.invalidResponse }

        return try JSONDecoder().decode(WeatherData.self, from: data)
    }
    
}
