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
    
    
    let service = WeatherApiService()
    @State private var weather: [ForecastDay] = []
//    private var weather = ForecastDay.mockForecast
    
    var body: some View {
        NavigationStack{
            ZStack {
                if let userRecord = userRecordData.first {
                    Color.stdBlue.ignoresSafeArea()
                    TabView{
                        ForEach(weather) { forecastDay in
                            ForecastDayView(forecastDay: forecastDay,
                                            userRecord: userRecord)
                        }
                    }
                    .padding()
                    .tabViewStyle(.page)
                    VStack{
                        HStack{
                            if let mainCode = userRecord.selectedZipCode{
                                Text(mainCode.name)
                                .padding(.leading)
                                .font(.title)
                                .bold()
                                .foregroundStyle(.white)
                                
                                Spacer()
                                SettingsView(userRecord: userRecord)
                                    .padding(.trailing)

                            } else {
                                ProgressView("Loading weather data...")
                            }
                        }
                        Spacer()
                    }
                } else {
                    ProgressView("Loading weather data...")
                }
            }
        }
        .task{
            if userRecordData.isEmpty{
                context.insert(UserRecord())
                try? context.save()
            }
            
        }
        .task(id: userRecordData.first?.selectedZipCode){
            do{
                let fetchedData: [ForecastDay]
                let code: String
                
                guard let userRecord = userRecordData.first,
                      let selectedZip = userRecord.selectedZipCode else {
                    print("Error: Could not retrieve UserRecord or selected zip code.")
                    return
                }
                
                code = selectedZip.code
                
                fetchedData = try await service.get7DayForecast(for: code)

                weather = fetchedData
            } catch {
                print("Error fetching weather data: \(error)")
            }

        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: UserRecord.self, inMemory: true)
}
