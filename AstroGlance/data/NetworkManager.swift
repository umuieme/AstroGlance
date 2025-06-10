//
//  NetworkManager.swift
//  AstroGlance
//
//  Created by Umesh Basnet on 2025-06-09.
//

import Foundation

class NetworkManager {
    
    private  let schema = "https"
    private  let host = "api.nasa.gov"
    
    private let apod = "/planetary/apod"
    
    public static let shared  = NetworkManager()
    
    func fetchDailyImageList(startDate: String, endDate: String) async throws -> [AstroDailyImage] {
                var components = URLComponents()
        components.scheme = schema
        components.host = host
        components.path = apod

        components.queryItems = [
            URLQueryItem(name: "api_key", value: ConfigData.shared.getApiKey()),
            URLQueryItem(name: "start_date", value: startDate),
            URLQueryItem(name: "end_date", value: endDate),
            URLQueryItem(name: "thumbs", value: "true")
        ]
        guard let url = components.url else {
                    throw ApiError.invalidUrl
                }
        let (data, error) = try await URLSession.shared.data(from: url)
        do {
            let decoder = JSONDecoder()
            return try decoder.decode([AstroDailyImage].self, from: data)
        } catch let error{
            throw ApiError.unknownError
        }
        
    }
    
    func saveImage(from url: String) async throws -> Data {
        guard let url = URL(string: url) else {
                    throw ApiError.invalidUrl
                }
        let (data, response) = try await URLSession.shared.data(from: url)
               guard let http = response as? HTTPURLResponse,
                     200..<300 ~= http.statusCode else {
                   throw URLError(.badServerResponse)
               }
               return data
    }
    
}
