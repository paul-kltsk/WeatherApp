//
//  NetworkManager.swift
//  WeatherApp
//
//  Created by Pavel Kylitsky on 10/02/2024.
//


import Foundation

class NetworkManager {
    
    enum APIError: Error {
        case invalidURL
        case requestFailed(Error)
        case invalidResponse
        case invalidData
    }
    
    static var shared = NetworkManager()
    
    private let token = "d1a6d6149ff14de667a0686e8dd35d0e"
    
    private let urlFirst = "https://api.openweathermap.org/data/2.5/forecast?units=metric&"
    
    func fetchData(lat: Double,
                   lon: Double,
                   completion: @escaping (Result<Data,APIError>) -> Void) {
        
        let fullUrl = urlFirst + "lat=\(lat)&lon=\(lon)&appid=\(token)"
        
        guard let url = URL(string: fullUrl) else {
            completion(.failure(.invalidURL))
            return
        }
        
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
                // Check for errors
                if let error = error {
                    completion(.failure(.requestFailed(error)))
                    return
                }

                // Check for a valid HTTP response
                guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                    completion(.failure(.invalidResponse))
                    return
                }

                // Check if data is available
                guard let data = data else {
                    completion(.failure(.invalidData))
                    return
                }

                // If all checks pass, call the completion handler with the data
                completion(.success(data))

            }.resume()
    }
    
}

