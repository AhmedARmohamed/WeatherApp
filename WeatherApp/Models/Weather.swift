//
//  Weather.swift
//  WeatherApp
//
//  Created by Ahmed Mohamed on 06/06/2021.
//

import Foundation

struct WeatherResponse: Codable {
    let lat: Float
    let lon: Float
    let timezone: String
    let timezone_offset: Float
    let current: CurrentWeather
//    let minutely: [Minutely]
    let hourly: [HourlyWeather]
    let daily: [daily]
}

struct CurrentWeather: Codable {
    let dt: Double
    let sunrise: Double
    let temp: Double
    let feels_like: Double
    let pressure: Double
    let humidity: Double
    let dew_point: Double
    let uvi: Double
    let clouds: Double
    let visibility: Double
    let wind_speed: Double
    let wind_deg: Double
    let weather: [Weather]
}

struct HourlyWeather: Codable {
    let dt: Double
    let temp: Double
    let feels_like: Double
    let pressure: Double
    let humidity: Int
    let dew_point: Double
    let uvi: Double
    let clouds: Int
    let visibility: Int
    let wind_speed: Double
    let wind_deg: Double
    let wind_gust: Double
    let weather: [Weather]
    let pop: Double
}

struct daily: Codable {
    let dt: Double
    let sunrise: Double
    let sunset: Double
    let moonrise: Double
    let moonset: Double
    let moon_phase: Double
    let temp: TempWeather
    let feels_like: feels_like
    let pressure: Double
    let humidity: Double
    let dew_point: Double
    let wind_speed: Double
    let wind_deg: Int
    let wind_gust: Double
    let weather: [Weather]
    let clouds: Int
    let pop: Double
//    let rain: Double
    let uvi: Double
}


struct Minutely: Codable {
    let dt: Double
    let precipitation: Int
}

struct Weather: Codable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}

struct TempWeather: Codable {
    let day: Double
    let min: Double
    let max: Double
    let night: Double
    let eve: Double
    let morn: Double
}

struct feels_like: Codable {
    let day: Double
    let night: Double
    let eve: Double
    let morn: Double
}


