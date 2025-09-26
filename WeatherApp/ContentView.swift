//
//  ContentView.swift
//  WeatherApp
//
//  Created by Caleb Wolfe on 9/13/25.
//

import SwiftUI


struct ContentView: View {
    let service = WeatherApiService()
//    private var weather: [ForecastDay] = []
    private var weather = ForecastDay.mockForecast
    
    var body: some View {
        ScrollView(.horizontal) {
            ForEach(weather) { forecastDay in
                Text("Data for \(forecastDay.date)")
            }
        }
        .padding()
//        .task {
//            do {
//                weather = try await service.get7DayForecast(for: "92336")
//            } catch {
//                print("Error fetching weather: \(error)")
//            }
//        }
    }
}

#Preview {
    ContentView()
}
