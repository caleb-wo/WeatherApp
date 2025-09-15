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
    private let apiKey :String? = {
        guard let path = Bundle.main.path(forResource: "Secrets",
                                          ofType: "plist"),
              let dict = NSDictionary(contentsOfFile: path) as? [String: AnyObject] else {
            return nil
        }
        guard let apiKey = dict["WeatherApiKey"] as? String else {
            return nil
        }
        
        return apiKey
    }()
    
    let baseUrl = URL(string: "https://api.weatherapi.com/v1/")
    
    private func get7DayForecastRequest(for zipcode: String) throws -> URLRequest {
        var components = URLComponents(url: baseUrl!, resolvingAgainstBaseURL: false)
        components?.queryItems = [
            URLQueryItem(name: "key", value: apiKey),
            URLQueryItem(name: "q", value: "\(zipcode)"),
            URLQueryItem(name: "days", value: "7")
        ]
        
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
    
    private func convertJSONToDict(using data: Data) throws -> [String: Any] {
        do {
            let json = try JSONSerialization.jsonObject(with: data, options: [])
            guard let dictionary = json as? [String: Any] else {
                throw APIError.decodingError
            }
            return dictionary
        } catch {
            throw APIError.decodingError
        }
    }
    
    func getForecastDictionary(from zipcode: String) async throws -> [String: Any] {
        do {
            let request = try get7DayForecastRequest(for: zipcode)
            let jsonData = try await get7DayForecastJSON(with: request)
            let forecastDictionary = try convertJSONToDict(using: jsonData)
            return forecastDictionary
        } catch {
            throw error
        }
    }
    
}

enum APIError: Error {
    case invalidURL
    case badServerResponse
    case decodingError
}

