//
//  ForecastDayView.swift
//  WeatherApp
//
//  Created by Caleb Wolfe on 9/25/25.
//

import SwiftUI

struct ForecastDayView: View {
    let forecastDay: ForecastDay
    
    var body: some View {
        Text("Success! The data is \(getDateObj(from: forecastDay.date))")
        
    }
    
    func getDateObj(from dateStr: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        return dateFormatter.date(from: dateStr)!
    }
}

//ForecastDay(
//    date: "2025-09-22",
//    day: DayInfo(
//        maxTempF: 75.2, minTempF: 50.1,
//        maxTempC: 24.0, minTempC: 10.0,
//        avgHumidity: 65,
//        maxWindMPH: 12.3, maxWindKPH: 19.8,
//        condition: Condition(text: "Partly cloudy", icon: "//cdn.weatherapi.com/weather/64x64/day/116.png"),
//        dailyChanceOfRain: 10, dailyChanceOfSnow: 0
//    ),
//    astro: Astro(
//        sunrise: "06:45 AM",
//        sunset: "07:15 PM",
//        moonrise: "8:00 PM",
//        moonset: "7:00 AM",
//        moonPhase: "Waxing Gibbous"
//    )
//)

#Preview {
    ForecastDayView(forecastDay: ForecastDay.mockForecast[0])
}
