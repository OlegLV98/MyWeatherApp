//
//  ContentView.swift
//  HW5Module4_LesnoyOleg
//
//  Created by Oleg Lesnoy on 04.08.2024.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel = WeatherViewModel.shared
    @State var city: String = ""
    var body: some View {
        VStack(spacing: 20) {
            HStack {
                TextField("Введите город", text: $city)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                
                Button(action: {
                    viewModel.getWeather(in: city)
                }) {
                    Image(systemName: "magnifyingglass")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
            .padding()
            
            Text(viewModel.weather?.name ?? "Неизвестный город")
                .font(.largeTitle)
                .bold()
            
            if let weatherDescription = viewModel.weather?.weather.first?.description {
                Text(weatherDescription.capitalized)
                    .font(.title2)
            }
            
            if let temp = viewModel.weather?.main.temp {
                Text("\(temp, specifier: "%.1f")°C")
                    .font(.system(size: 60))
                    .bold()
            }

            HStack(spacing: 40) {
                if let feelsLike = viewModel.weather?.main.feels_like {
                    VStack {
                        Text("Ощущается как")
                            .font(.subheadline)
                        Text("\(feelsLike, specifier: "%.1f")°C")
                            .font(.title3)
                    }
                }

                if let tempMin = viewModel.weather?.main.temp_min, let tempMax = viewModel.weather?.main.temp_max {
                    VStack {
                        Text("Мин / Макс")
                            .font(.subheadline)
                        Text("\(tempMin, specifier: "%.1f")°C / \(tempMax, specifier: "%.1f")°C")
                            .font(.title3)
                    }
                }
            }

            HStack(spacing: 40) {
                if let humidity = viewModel.weather?.main.humidity {
                    VStack {
                        Text("Влажность")
                            .font(.subheadline)
                        Text("\(humidity, specifier: "%.0f")%")
                            .font(.title3)
                    }
                }

                if let pressure = viewModel.weather?.main.pressure {
                    VStack {
                        Text("Давление")
                            .font(.subheadline)
                        Text("\(pressure, specifier: "%.0f") гПа")
                            .font(.title3)
                    }
                }

                if let windSpeed = viewModel.weather?.wind.speed {
                    VStack {
                        Text("Ветер")
                            .font(.subheadline)
                        Text("\(windSpeed, specifier: "%.1f") м/с")
                            .font(.title3)
                    }
                }
            }
        }
        .padding()
    }
}
