//
//  WeatherApiTests.swift
//  WeatherAppTests
//
//  Created by Caleb Wolfe on 9/17/25.
//

import Testing
@testable import WeatherApp

struct WeatherApiTests {

    @Test("Check JSON GET request")
    func get7DayForecastJSONTest() async throws {
        let apiService = WeatherApiService()
        
        let forecastArray = try await apiService.get7DayForecast(for: "92336")
        
        #expect(!forecastArray.isEmpty)
        #expect(forecastArray.count == 3)
    }
    
    @Test("Check forecast date strings")
    func getForecastDateStringsTest() async throws {
        let apiService = WeatherApiService()
        let forecastArray = try await apiService.get7DayForecast(for: "92336")
        
        let dateStrings = try forecastArray.map() { forecast in
            try forecast.getDateInfo()
        }
        
        for date in dateStrings {
            #expect(date is (String, String))
        }
        #expect(dateStrings.count == 3)
    }

}
