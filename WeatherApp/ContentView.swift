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
    }
}

#Preview {
    ContentView()
}
