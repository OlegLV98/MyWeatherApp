//
//  NetworkManager.swift
//  HW5Module4_LesnoyOleg
//
//  Created by Oleg Lesnoy on 04.08.2024.
//

import Foundation

protocol NetworkManagerProtocol {
    var url: URL? {get set}
    var urlRequest: URLRequest? {get set}
    func sendRequest(city: String, completion: @escaping (Result<City, Error>) -> Void)
}

class NetworkManager: NetworkManagerProtocol {
    var url: URL?
    
    var urlRequest: URLRequest?
    static let shared = NetworkManager()
    private init() {}
    
    
    func sendRequest(city: String, completion: @escaping (Result<City, Error>) -> Void) {
        var urlComponents = URLComponents()
                urlComponents.scheme = "https"
                urlComponents.host = "api.openweathermap.org"
                urlComponents.path = "/data/2.5/weather"
                urlComponents.queryItems = [
                    URLQueryItem(name: "appid", value: "6c7483cdf3bf04b9afbdecfecede7c5f"),
                    URLQueryItem(name: "q", value: city),
                    URLQueryItem(name: "units", value: "metric"),
                    URLQueryItem(name: "lang", value: "ru")
                ]
        url = urlComponents.url
        guard let url else {
            return
        }
        urlRequest = URLRequest(url: url)
        guard let urlRequest else {
            return
        }
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            if let error {
                completion(.failure(error))
            }
            guard let data else {
                completion(.failure(NetworkError.noData))
                return
            }
          
            let jsonData = try? JSONDecoder().decode(City.self, from: data)
            guard let jsonData else {
                completion(.failure(DecoderError.badData))
                return
            }
            completion(.success(jsonData))
        }.resume()
    }
}

enum NetworkError: Error {
    case noData
}

enum DecoderError: Error {
    case badData
}
