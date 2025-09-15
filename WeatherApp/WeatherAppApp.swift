//
//  WeatherAppApp.swift
//  WeatherApp
//
//  Created by Caleb Wolfe on 9/13/25.
//

import SwiftUI

@main
struct WeatherAppApp: App {
    let service = WeatherApiService()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
