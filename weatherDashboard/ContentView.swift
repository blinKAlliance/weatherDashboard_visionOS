//
//  ContentView.swift
//  firstProject
//
//  Created by Jordan Kramer on 6/7/24.
//

import SwiftUI
import RealityKit
import RealityKitContent

struct ContentView: View {
    @StateObject var viewModel = WeatherViewModel()
        
    var body: some View {
        VStack {
            HStack {
                TimeCardView()
            }
            HStack {
                TemperatureCardView(temperaturesAtNoon: viewModel.temperaturesAtNoon, dates: viewModel.dates)
                FiveHourForecastView(fiveHourForecast: viewModel.fiveHourForecast)
            }
        }
        .onAppear {
            viewModel.fetchWeather()
        }
    }
}

#Preview(windowStyle: .automatic) {
    ContentView()
}
