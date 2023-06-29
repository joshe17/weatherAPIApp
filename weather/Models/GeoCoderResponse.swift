//
//  GeoCoderResponse.swift
//  weather
//
//  Created by Joshua Ho on 6/25/23.
//

import Foundation

struct GeoCoder: Codable, Hashable {
    let name: String
    let lat: Double
    let lon: Double
    
    private enum CodingKeys: String, CodingKey {
        case name = "name"
        case lat = "lat"
        case lon = "lon"
    }
}
