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
        
        do{
            var data = try? await apiService.getForecastDictionary(from: "92336")
        }
    }

}
