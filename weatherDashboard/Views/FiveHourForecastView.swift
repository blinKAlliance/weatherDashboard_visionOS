//
//  FiveHourForecastView.swift
//  firstProject
//
//  Created by Jordan Kramer on 6/7/24.
//

import Foundation
import SwiftUI

struct FiveHourForecastView: View {
    var fiveHourForecast: [(time: String, temperature: Int, precipitationProbability: Int)]
    
    var body: some View {
        VStack {
            Text("Hourly Forecast")
                .font(.title)
                .fontWeight(.bold)
            HStack(spacing: 10) {
                ForEach(fiveHourForecast, id: \.0) { forecast in
                    VStack {
                        WeatherIconView()
                            .frame(width: 30, height: 30)
                        
                        Text("\(forecast.1)°F")
                            .font(.headline)
                            .fontWeight(.bold)
                            .padding(.bottom)
                        
                        WeatherIconView(imageType: .rain)
                            .frame(width: 30, height: 30)
                        
                        Text("\(forecast.2)%")
                            .font(.headline)
                            .fontWeight(.bold)
                    }
                    .padding()
                    .background(Color.black.opacity(0.2))
                    .cornerRadius(20)
                }
            }
        }
        .frame(width: 500, height: 310)
        .padding()
        .background(Color.white.opacity(0.4))
        .cornerRadius(20)
    }
}
