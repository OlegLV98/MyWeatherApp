//
//  WeatherViewModel.swift
//  HW5Module4_LesnoyOleg
//
//  Created by Oleg Lesnoy on 04.08.2024.
//

import SwiftUI

class WeatherViewModel: ObservableObject {
    static let shared = WeatherViewModel()
    private init() {}
    var networkManager = NetworkManager.shared
    @Published var weather: City?
    func getWeather(in city: String) {
        networkManager.sendRequest(city: city) { result in
            switch result {
            case .success(let weather):
                DispatchQueue.main.async { [weak self] in
                    guard let self else {return}
                    self.weather = weather
                }
            case .failure(let error):
                DispatchQueue.main.async { [weak self] in
                    guard let self else {return}
                    weather = nil
                    print(error.localizedDescription)
                }
            }
        }
    }
}
