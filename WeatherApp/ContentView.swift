//
//  ContentView.swift
//  WeatherApp
//
//  Created by Caleb Wolfe on 9/13/25.
//

import SwiftUI
import SwiftData


struct ContentView: View {
    @Query private var userRecord: [UserRecord]
    @Environment(\.modelContext) var context
    
    let service = WeatherApiService()
    @State private var weather: [ForecastDay] = []
    var zipcode = "83440"
//    private var weather = ForecastDay.mockForecast
    
    var body: some View {
        ZStack {
            Color.stdBlue.ignoresSafeArea()
            TabView{
                ForEach(weather) { forecastDay in
                    ForecastDayView(forecastDay: forecastDay,
                                    userRecord: userRecord[0])
                }
            }
            .padding()
            .tabViewStyle(.page)
            VStack{
                HStack{
                    Spacer()
                    SettingsView(userRecord: userRecord[0])
                        .padding(.trailing)
                }
                Spacer()
            }
        }
        .task{
            context.insert(UserRecord())
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
        .modelContainer(for: UserRecord.self, inMemory: true)
}
