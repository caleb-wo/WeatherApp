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
    var zipcode = "83440"
//    private var weather = ForecastDay.mockForecast
    
    var body: some View {
        ZStack {
            Color.stdBlue.ignoresSafeArea()
            TabView{
                ForEach(weather) { forecastDay in
                    ForecastDayView(forecastDay: forecastDay)
                }
            }
            .padding()
            .tabViewStyle(.page)
            VStack{
                HStack{
                    Spacer()
                    SettingsView()
                        .padding(.trailing)
                }
                Spacer()
            }
        }
        .task{
            do{
                let fetchedData = try await service.get7DayForecast(for: zipcode)
                
                weather = fetchedData
            } catch {
                print("Error fetching weather data for \(zipcode): \(error)")
            }
        }
    }
}

#Preview {
    ContentView()
}
