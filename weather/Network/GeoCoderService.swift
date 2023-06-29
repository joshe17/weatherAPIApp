//
//  GeoCoderService.swift
//  weather
//
//  Created by Joshua Ho on 6/25/23.
//

import Foundation
import Combine

class GeoCoderService {
    var cancellable = Set<AnyCancellable>()
    var apiKey = "84247281be424403b8aed106b3b76e11"
    
    //NOT SURE IF I SHOULD BE RETURNING AN ARRAY HERE
    func fetchGeoCoderData(cityName: String) async throws -> [GeoCoder] {
        var urlString = "https://api.openweathermap.org/geo/1.0/direct?q=\(cityName.replacingOccurrences(of: ", ", with: ","))"
        urlString = urlString.replacingOccurrences(of: " ", with: "+")

        urlString += "&appid=\(apiKey)"
        guard let url = URL(string: urlString) else { throw APIError.invalidUrl }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let resp = response as? HTTPURLResponse, resp.statusCode == 200 else { throw APIError.invalidResponse }
        return try JSONDecoder().decode([GeoCoder].self, from: data)
    }
    
}
