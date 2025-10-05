//
//  WeatherApi.swift
//  WeatherApp
//
//  Created by Caleb Wolfe on 9/13/25.
//
import Foundation

/// The WeatherApiService is the portal by which the rest of the
/// application access the free weather data, courtesy of
/// weatherapi.com. It abstracts JSON parsing and data
/// cleaning, providing useful functions for the application.
public struct WeatherApiService {
    
    // Safely collect api key from property list.
    private let apiKey: String? = {
        guard let path = Bundle.main.url(forResource: "Secrets",
                                        withExtension: "plist"),
              let data = try? Data(contentsOf: path) else {
            print("Error: Could not find Secrets.plist or read data.")
            return nil
        }

        do {
            let decoder = PropertyListDecoder()
            let secrets = try decoder.decode(Secrets.self, from: data)
            return secrets.WeatherApiKey
        } catch {
            print("Error decoding plist: \(error)")
            return nil
        }
    }()
    
    let baseUrl = URL(string: "https://api.weatherapi.com")
    let decoder = JSONDecoder()

    private func get7DayForecastRequest(for zipcode: String) throws -> URLRequest {
        var components = URLComponents(url: baseUrl!, resolvingAgainstBaseURL: false)
        components?.queryItems = [
            URLQueryItem(name: "key", value: apiKey),
            URLQueryItem(name: "q", value: "\(zipcode)"),
            URLQueryItem(name: "days", value: "3"),
            URLQueryItem(name: "aqi", value: "no"),
            URLQueryItem(name: "alerts", value: "no")
        ]
        
        components?.path = "/v1/forecast.json"
        guard let url = components?.url else {
            throw APIError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        return request
    }
    
    private func get7DayForecastJSON(with request: URLRequest) async throws -> Data{
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            throw APIError.badServerResponse
        }
        
        return data
    }
    
    private func parseJSON(using data: Data) throws -> [ForecastDay] {
        do {
            let weatherResponse = try decoder.decode(WeatherResponse.self, from: data)
            let forecast = weatherResponse.forecast.forecastDays
            
            print("Successfully decoded \(forecast.count) days of forecasts.")
            return forecast
        } catch {
            throw APIError.decodingError
        }
    }
    
    func get7DayForecast(for zipcode: String) async throws -> [ForecastDay] {
        do {
            let request = try get7DayForecastRequest(for: zipcode)
            let jsonData = try await get7DayForecastJSON(with: request)
            let forecastArray = try parseJSON(using: jsonData)
            return forecastArray
        } catch {
            throw error
        }
    }
    
}

struct Secrets: Decodable {
    let WeatherApiKey: String
}

enum APIError: Error {
    case invalidURL
    case badServerResponse
    case decodingError
}

