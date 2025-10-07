//
//  ForecastDetailedView.swift
//  WeatherApp
//
//  Created by Caleb Wolfe on 10/7/25.


import SwiftUI

struct ForecastDetailedView: View {
    @State var forecastDay: ForecastDay
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
                        Image(systemName: "xmark.circle.fill")
                        
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
                        .padding(.bottom, 40)
                        
                        Grid{
                            GridRow{
                                VStack(alignment: .leading){
                                    HStack{Spacer();Text("Farenhiet");Spacer()}
                                        .font(.title2)
                                        .foregroundColor(.white)
                                    
                                        Text("Max Temp: \(forecastDay.day.maxTempF, specifier: "%.1f")℉")
                                        .font(.headline)
                                        .padding(.leading)
                                        .foregroundStyle(.white)
                                    Text("Min Temp: \(forecastDay.day.minTempF, specifier: "%.1f")℉")
                                        .font(.headline)
                                        .padding(.leading)
                                        .foregroundStyle(.white)
                                }
                            }
                            GridRow{
                                HStack{Spacer();Text("Celsius");Spacer()}
                                    .font(.title2)
                                    .foregroundColor(.white)
                            }
                        }
                    }
                    .background(.gray,
                                in: ConcentricRectangle(
                                    corners: .concentric(minimum: 20),
                                    isUniform: true))
                    .padding()
                    Spacer()
                }
            }
        }
    }
}

#Preview {
    @State @Previewable var fday = ForecastDay.mockForecast[0]
    ForecastDetailedView(forecastDay: fday)
}
