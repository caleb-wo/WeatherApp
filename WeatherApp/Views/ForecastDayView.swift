//
//  ForecastDayView.swift
//  WeatherApp
//
//  Created by Caleb Wolfe on 9/25/25.
//

import SwiftUI

struct ForecastDayView: View {
    let forecastDay: ForecastDay
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    ForecastDayView(forecastDay: ForecastDay.mockForecast[0])
}
