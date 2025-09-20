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
        
        #expect(forecastArray is [ForecastDay])
        #expect(!forecastArray.isEmpty)
        #expect(forecastArray.count == 7)
    }

}
