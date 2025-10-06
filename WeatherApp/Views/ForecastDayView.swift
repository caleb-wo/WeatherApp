//
//  ForecastDayView.swift
//  WeatherApp
//
//  Created by Caleb Wolfe on 9/25/25.
//

import SwiftUI
import SwiftData

struct ForecastDayView: View {
    let forecastDay: ForecastDay
    @State var userRecord: UserRecord
    let urlStub = "https:"
    var dateInfoOpt: (day: String, monthAndDay: String)? {
        try? forecastDay.getDateInfo()
    }
    
    var body: some View {
        if let dateInfo = dateInfoOpt {
            let primaryColor = Color.stdBlue
            let maxTemp = userRecord.isFarenhiet ? forecastDay.day.maxTempF : forecastDay.day.maxTempC
            let minTemp = userRecord.isFarenhiet ? forecastDay.day.minTempF : forecastDay.day.minTempC

            ZStack {
                primaryColor
                    .ignoresSafeArea(edges: .all)
                
                Spacer()
                VStack{
                    VStack(spacing: 10){
                        Text("\(dateInfo.day)")
                            .font(.largeTitle)
                            .padding([.top, .leading, .trailing], 50)
                            .foregroundStyle(primaryColor)
                            .bold()
                        
                        Text("\(dateInfo.monthAndDay)")
                            .font(.title2)
                            .foregroundStyle(primaryColor.opacity(0.7))
                        
                        HStack{
                            Text("\(forecastDay.day.condition.text)")
                                .font(.title2)
                            AsyncImage(url: URL(
                                string: urlStub + forecastDay.day.condition.icon)){ phase in
                                    switch phase {
                                    case .empty:
                                        ProgressView()
                                    case .success(let image):
                                        image
                                            .padding(0)
                                    case .failure:
                                        EmptyView()
                                    @unknown default:
                                        EmptyView()
                                    }
                                }
                        }

                        List{
                            Text("Max Temp: \(maxTemp, specifier: "%.1f")º")
                            Text("Min Temp: \(minTemp, specifier: "%.1f")º")
                        }
                        .font(.headline)
                        .frame(maxHeight: 175)
                        .clipShape(ConcentricRectangle(corners: .concentric(minimum: 20), isUniform: true))
                    }
                    .frame(maxWidth: 300)
                    .background(.white,
                                in: ConcentricRectangle(corners: .concentric(minimum: 20),
                                                        isUniform: true))
                    Button("MORE"){
                        
                    }
                    .frame(maxWidth: 275)
                    .font(.headline)
                    .padding(10)
                    .glassEffect(in: RoundedRectangle(cornerRadius: 20))
                }
                Spacer()
                

            } // ZStack
        } else {
            Text("Error getting date information. Report bug.")
        }
    } // Body
    
}

//ForecastDay(
//    date: "2025-09-22",
//    day: DayInfo(
//        maxTempF: 75.2, minTempF: 50.1,
//        maxTempC: 24.0, minTempC: 10.0,
//        avgHumidity: 65,
//        maxWindMPH: 12.3, maxWindKPH: 19.8,
//        condition: Condition(text: "Partly cloudy", icon: "//cdn.weatherapi.com/weather/64x64/day/116.png"),
//        dailyChanceOfRain: 10, dailyChanceOfSnow: 0
//    ),
//    astro: Astro(
//        sunrise: "06:45 AM",
//        sunset: "07:15 PM",
//        moonrise: "8:00 PM",
//        moonset: "7:00 AM",
//        moonPhase: "Waxing Gibbous"
//    )
//)

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: UserRecord.self, configurations: config)

    let sampleRecord = UserRecord()
    
    ForecastDayView(forecastDay: ForecastDay.mockForecast[0],
                    userRecord: sampleRecord)
    .modelContainer(container)
}
