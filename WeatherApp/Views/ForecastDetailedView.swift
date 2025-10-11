//
//  ForecastDetailedView.swift
//  WeatherApp
//
//  Created by Caleb Wolfe on 10/7/25.


import SwiftUI

struct ForecastDetailedView: View {
    @State var forecastDay: ForecastDay
    @Environment(\.dismiss) var dismiss
    
    private let primaryColor = Color.stdBlue
    let urlStub = "https:"
    
    var body: some View {
        if let dateData = try? forecastDay.getDateInfo() {
            ZStack{
                primaryColor.ignoresSafeArea(edges: .all)
                VStack{
                    HStack{
                        Text("\(dateData.monthAndDay)")
                        Spacer()
                        Button {
                            dismiss()
                        } label: {
                            Image(systemName: "xmark.circle.fill")
                        }
                        
                    }
                    .padding()
                    .font(.title)
                    .fontWeight(.medium)
                    .foregroundColor(.white)
                    
                    VStack{
                        Text("\(dateData.day)")
                            .font(.largeTitle)
                            .bold()
                            .foregroundColor(.white)
                            .padding(.top, 20)
                        
                        HStack{
                            Text("\(forecastDay.day.condition.text)")
                                .font(.title2)
                                .foregroundStyle(.white)
                            
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
                        .padding(.top, -10)
                        .padding(.bottom, 20)
                        
                        
                        List{
                            VStack(alignment: .leading){
                                HStack{Spacer();Text("Farenhiet").padding();Spacer()}
                                    .background(.gray.opacity(0.15),
                                                in: ConcentricRectangle(
                                                    corners: .concentric(minimum: 20),
                                                    isUniform: true))
                                    .font(.title2)
                                    .bold()
                                Text("Max Temp: \(forecastDay.day.maxTempF, specifier: "%.1f") ℉")
                                Text("Min Temp: \(forecastDay.day.minTempF, specifier: "%.1f") ℉")
                            }
                            .padding(.leading)
                            .lineHeight(.loose)

                            VStack(alignment: .leading){
                                HStack{Spacer();Text("Celsius").padding();Spacer()}
                                    .background(.gray.opacity(0.15),
                                                in: ConcentricRectangle(
                                                    corners: .concentric(minimum: 20),
                                                    isUniform: true))
                                    .font(.title2)
                                    .bold()
                                Text("Max Temp: \(forecastDay.day.maxTempC, specifier: "%.1f") ℃")
                                Text("Min Temp: \(forecastDay.day.minTempC, specifier: "%.1f") ℃")
                            }
                            .padding(.leading)
                            .lineHeight(.loose)

                            VStack(alignment: .leading){
                                HStack{Spacer();Text("Atmospheric Conditions").padding();Spacer()}
                                    .background(.gray.opacity(0.15),
                                                in: ConcentricRectangle(
                                                    corners: .concentric(minimum: 20),
                                                    isUniform: true))
                                    .font(.title2)
                                    .bold()
                                Text("Avg. Humidity: \(forecastDay.day.avgHumidity)")
                                Text("Max Wind: \(forecastDay.day.maxWindMPH, specifier: "%.1f") MPH | \(forecastDay.day.maxWindKPH, specifier: "%.1f") KPH")
                                Text("Chance of Rain: \(forecastDay.day.dailyChanceOfRain)")
                                Text("Chance of Snow: \(forecastDay.day.dailyChanceOfSnow)")
                            }
                            .padding(.leading)
                            .lineHeight(.loose)

                            VStack(alignment: .leading){
                                let astro = forecastDay.astro
                                HStack{Spacer();Text("Astrology").padding();Spacer()}
                                    .background(.gray.opacity(0.15),
                                                in: ConcentricRectangle(
                                                    corners: .concentric(minimum: 20),
                                                    isUniform: true))
                                    .font(.title2)
                                    .bold()
                                Text("Sunrise: \(astro.sunrise)")
                                Text("Sunset: \(astro.sunset)")
                                Text("Moon Phase: \(astro.moonPhase)")
                                Text("Moonrise: \(astro.moonrise)")
                                Text("Moonset: \(astro.moonset)")
                            }
                            .padding(.leading)
                            .lineHeight(.loose)
                        }
                    }
                }
            }
            .navigationBarBackButtonHidden(true)
        }
    }
}

#Preview {
    @State @Previewable var fday = ForecastDay.mockForecast[0]
    ForecastDetailedView(forecastDay: fday)
}
