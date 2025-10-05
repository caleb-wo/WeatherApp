//
//  WeatherAppApp.swift
//  WeatherApp
//
//  Created by Caleb Wolfe on 9/13/25.
//

import SwiftUI
import SwiftData

@main
struct WeatherAppApp: App {
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: UserRecord.self)
        }
    }
}
