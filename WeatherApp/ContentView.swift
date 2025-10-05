//
//  ContentView.swift
//  WeatherApp
//
//  Created by Caleb Wolfe on 9/13/25.
//

import SwiftUI
import SwiftData


struct ContentView: View {
    @Query private var userRecordData: [UserRecord]
    @Environment(\.modelContext) var context
    @State private var userRecord: UserRecord? = nil
    
    
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
                                    userRecord: userRecord!)
                }
            }
            .padding()
            .tabViewStyle(.page)
            VStack{
                HStack{
                    Spacer()
                    SettingsView(userRecord: userRecord!)
                        .padding(.trailing)
                }
                Spacer()
            }
        }
        .task{
            if userRecordData.isEmpty{
                userRecord = UserRecord()
                
                context.insert(userRecord!)
                try? context.save()
            } else {
                userRecord = userRecordData.first!
            }
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
