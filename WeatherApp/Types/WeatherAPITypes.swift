//
//  WeatherAPITypes.swift
//  WeatherApp
//
//  Created by Caleb Wolfe on 9/19/25.
//

import Foundation

/// Type for the initial JSON data. It sits at the top of the hierarchy.
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

struct ForecastDay: Decodable, Identifiable {
    var id = UUID()
    let date: String
    let dateEpoch: TimeInterval
    let day: DayInfo
    let astro: Astro
    
    /// Added coding to omit the ID.
    private enum CodingKeys: String, CodingKey {
        case date
        case dateEpoch = "date_epoch"
        case day
        case astro
     }
    
    
    func getDateInfo() throws -> (day: String, monthAndDay: String) {
        let dateObject = Date(timeIntervalSince1970: dateEpoch)
        let dayName = dateObject.formatted(.dateTime.weekday(.wide))
        let monthDayStr = dateObject.formatted(.dateTime
                                                .month(.defaultDigits)
                                                .day(.twoDigits))
        
        return (day: dayName, monthAndDay: monthDayStr)
    }

//    func getDateInfo() throws -> (day: String, monthAndDay: String) {
//        let inputFormatter = DateFormatter()
//        inputFormatter.dateFormat = "yyyy-MM-dd"
//        inputFormatter.timeZone = TimeZone(secondsFromGMT: 0)
//        
//        guard let dateObject = inputFormatter.date(from: date) else {
//            throw DateParsingError.couldNotParseDate("Could not parse Date object from \(date)")
//        }
//        
//        let dayGetter = DateFormatter()
//        dayGetter.dateFormat = "EEEE"
//        dayGetter.locale = Locale(identifier: "en_US")
//        let dayName = dayGetter.string(from: dateObject )
//        
//        let monthDayGetter = DateFormatter()
//        monthDayGetter.dateFormat = "M/dd"
//        let monthDayStr = monthDayGetter.string(from: dateObject )
//        
//        return (day: dayName, monthAndDay: monthDayStr)
//    }
    
    /// ForecastDay errors
    enum DateParsingError: Error{
        case couldNotParseDate(String)
    }
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
    let dailyChanceOfSnow: Int // daily_chance_of_snow

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
        case dailyChanceOfSnow = "daily_chance_of_snow"
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
    
    private enum CodingKeys: String, CodingKey {
        case sunrise
        case sunset
        case moonrise
        case moonset
        
        case moonPhase = "moon_phase"
    }
}


extension ForecastDay {
    static var mockForecast: [ForecastDay] {[
        ForecastDay(
            date: "2025-09-22",
            dateEpoch: 1759536000,
            day: DayInfo(
                maxTempF: 75.2, minTempF: 50.1,
                maxTempC: 24.0, minTempC: 10.0,
                avgHumidity: 65,
                maxWindMPH: 12.3, maxWindKPH: 19.8,
                condition: Condition(text: "Partly cloudy",
                                     icon: "//cdn.weatherapi.com/weather/64x64/day/116.png"),
                dailyChanceOfRain: 10, dailyChanceOfSnow: 0
            ),
            astro: Astro(
                sunrise: "06:45 AM",
                sunset: "07:15 PM",
                moonrise: "8:00 PM",
                moonset: "7:00 AM",
                moonPhase: "Waxing Gibbous"
            )
        ),
        ForecastDay(
            date: "2025-09-23",
            dateEpoch: 1759536000,
            day: DayInfo(
                maxTempF: 74.8, minTempF: 52.8,
                maxTempC: 22.0, minTempC: 12.0,
                avgHumidity: 83,
                maxWindMPH: 12.3, maxWindKPH: 19.8,
                condition: Condition(text: "Partly cloudy",
                                     icon: "//cdn.weatherapi.com/weather/64x64/day/116.png"),
                dailyChanceOfRain: 10, dailyChanceOfSnow: 0
            ),
            astro: Astro(
                sunrise: "06:45 AM",
                sunset: "07:15 PM",
                moonrise: "8:00 PM",
                moonset: "7:00 AM",
                moonPhase: "Waxing Gibbous"
            )
        ),
        ForecastDay(
            date: "2025-09-24",
            dateEpoch: 1759536000,
            day: DayInfo(
                maxTempF: 74.8, minTempF: 52.8,
                maxTempC: 22.0, minTempC: 12.0,
                avgHumidity: 83,
                maxWindMPH: 12.3, maxWindKPH: 19.8,
                condition: Condition(text: "Partly cloudy",
                                     icon: "//cdn.weatherapi.com/weather/64x64/day/116.png"),
                dailyChanceOfRain: 10, dailyChanceOfSnow: 0
            ),
            astro: Astro(
                sunrise: "06:45 AM",
                sunset: "07:15 PM",
                moonrise: "8:00 PM",
                moonset: "7:00 AM",
                moonPhase: "Waxing Gibbous"
            )
        ),
        ForecastDay(
            date: "2025-09-25",
            dateEpoch: 1759536000,
            day: DayInfo(
                maxTempF: 74.8, minTempF: 52.8,
                maxTempC: 22.0, minTempC: 12.0,
                avgHumidity: 83,
                maxWindMPH: 12.3, maxWindKPH: 19.8,
                condition: Condition(text: "Partly cloudy",
                                     icon: "//cdn.weatherapi.com/weather/64x64/day/116.png"),
                dailyChanceOfRain: 10, dailyChanceOfSnow: 0
            ),
            astro: Astro(
                sunrise: "06:45 AM",
                sunset: "07:15 PM",
                moonrise: "8:00 PM",
                moonset: "7:00 AM",
                moonPhase: "Waxing Gibbous"
            )
        ),
        ForecastDay(
            date: "2025-09-26",
            dateEpoch: 1759536000,
            day: DayInfo(
                maxTempF: 74.8, minTempF: 52.8,
                maxTempC: 22.0, minTempC: 12.0,
                avgHumidity: 83,
                maxWindMPH: 12.3, maxWindKPH: 19.8,
                condition: Condition(text: "Partly cloudy",
                                     icon: "//cdn.weatherapi.com/weather/64x64/day/116.png"),
                dailyChanceOfRain: 10, dailyChanceOfSnow: 0
            ),
            astro: Astro(
                sunrise: "06:45 AM",
                sunset: "07:15 PM",
                moonrise: "8:00 PM",
                moonset: "7:00 AM",
                moonPhase: "Waxing Gibbous"
            )
        ),
        ForecastDay(
            date: "2025-09-27",
            dateEpoch: 1759536000,
            day: DayInfo(
                maxTempF: 74.8, minTempF: 52.8,
                maxTempC: 22.0, minTempC: 12.0,
                avgHumidity: 83,
                maxWindMPH: 12.3, maxWindKPH: 19.8,
                condition: Condition(text: "Partly cloudy",
                                     icon: "//cdn.weatherapi.com/weather/64x64/day/116.png"),
                dailyChanceOfRain: 10, dailyChanceOfSnow: 0
            ),
            astro: Astro(
                sunrise: "06:45 AM",
                sunset: "07:15 PM",
                moonrise: "8:00 PM",
                moonset: "7:00 AM",
                moonPhase: "Waxing Gibbous"
            )
        ),
        ForecastDay(
            date: "2025-09-28",
            dateEpoch: 1759536000,
            day: DayInfo(
                maxTempF: 74.8, minTempF: 52.8,
                maxTempC: 22.0, minTempC: 12.0,
                avgHumidity: 83,
                maxWindMPH: 12.3, maxWindKPH: 19.8,
                condition: Condition(text: "Partly cloudy",
                                     icon: "//cdn.weatherapi.com/weather/64x64/day/116.png"),
                dailyChanceOfRain: 10, dailyChanceOfSnow: 0
            ),
            astro: Astro(
                sunrise: "06:45 AM",
                sunset: "07:15 PM",
                moonrise: "8:00 PM",
                moonset: "7:00 AM",
                moonPhase: "Waxing Gibbous"
            )
        )
    ]}
}
