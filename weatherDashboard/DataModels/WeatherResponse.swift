//
//  WeatherResponse.swift
//  firstProject
//
//  Created by Jordan Kramer on 6/7/24.
//

import Foundation

struct WeatherResponse: Codable {
    let latitude: Double
    let longitude: Double
    let generationtime_ms: Double
    let utc_offset_seconds: Int
    let timezone: String
    let timezone_abbreviation: String
    let elevation: Double
    let hourly_units: HourlyUnits
    let hourly: HourlyData
}

struct HourlyUnits: Codable {
    let time: String
    let temperature_2m: String
    let precipitation_probability: String
}

struct HourlyData: Codable {
    let time: [String]
    let temperature_2m: [Double]
    let precipitation_probability: [Int]
}


