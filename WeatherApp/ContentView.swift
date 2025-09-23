//
//  ContentView.swift
//  WeatherApp
//
//  Created by Caleb Wolfe on 9/13/25.
//

import SwiftUI


struct ContentView: View {
    let service = WeatherApiService()
    @State private var weather: [ForecastDay] = []

    var body: some View {
        VStack {
              // Check if we have data before trying to display it
              if weather.isEmpty {
                  ProgressView("Loading weather...")
              } else {
                  Text("Weather for the next \(weather.count) days")
                  // Loop through and display the forecast data
                  List(weather, id: \.date) { day in
                      Text("Date: \(day.date), Condition: \(day.day.condition.text)")
                  }
              }
        }
        .padding()
        .task {
            do {
                weather = try await service.get7DayForecast(for: "92336")
            } catch {
                print("Error fetching weather: \(error)")
            }
        }
    }
}

#Preview {
    ContentView()
}
