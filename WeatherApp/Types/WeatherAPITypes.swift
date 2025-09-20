//
//  WeatherAPITypes.swift
//  WeatherApp
//
//  Created by Caleb Wolfe on 9/19/25.
//

import Foundation

/// Type for the initial JSON data. It sits at the top of the heiarchy.
/// As we decend the JSON object, minimal decodable-structs are defined
/// in order to get the forecast day data.
struct WeatherResponse: Decodable{
    let forecast: Forecast
}

struct Forecast: Decodable{
    let forecastDays: [ForecastDay]
    
    private enum CodingKeys: String, CodingKey {
        case forecastDays = "forecastday"
    }
}

struct ForecastDay: Decodable {
    let date: String
    
    let day: DayInfo
    
    let astro: Astro
}

struct DayInfo: Decodable {
    let maxTempF: Double // maxtemp_f
    let minTempF: Double // mintemp_f
    
    let maxTempC: Double // maxtemp_c
    let minTempC: Double // mintemp_c
    
    let avgHumidity: Int // avghumidity
    
    let maxWindMPH: Double // maxwind_mph
    let maxWindKPH: Double // maxwind_kph
    
    let condition: Condition
    
    let dailyChanceOfRain: Int // daily_chance_of_rain

    private enum CodingKeys: String, CodingKey {
        case maxTempF = "maxtemp_f"
        case minTempF = "mintemp_f"
        
        case maxTempC = "maxtemp_c"
        case minTempC = "mintemp_c"
        
        case avgHumidity = "avghumidity"
        
        case maxWindMPH = "maxwind_mph"
        case maxWindKPH = "maxwind_kph"
        
        case condition
        
        case dailyChanceOfRain = "daily_chance_of_rain"
    }
}

struct Condition: Decodable{
    let text: String
    let icon: String
}

struct Astro: Decodable{
    let sunrise: String
    let sunset: String
    
    let moonrise: String
    let moonset: String
    
    let moonPhase: String
    
    private enum CodindKeys: String, CodingKey {
        case sunrise
        case sunset
        case moonrise
        case moonset
        
        case moonPhase = "moon_phase"
    }
}
