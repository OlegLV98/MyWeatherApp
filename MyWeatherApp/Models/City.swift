//
//  City.swift
//  HW5Module4_LesnoyOleg
//
//  Created by Oleg Lesnoy on 04.08.2024.
//

import Foundation

struct City: Decodable {
    let weather: [Weather]
    let main: Main
    let wind: Wind
    let name: String?
}
struct Wind: Decodable {
    let speed: Double?
}
struct Weather: Decodable {
    let description: String?
}

struct Main: Decodable {
    let temp: Double?
    let feels_like: Double?
    let temp_min: Double?
    let temp_max: Double?
    let pressure: Double?
    let humidity: Double?
}

