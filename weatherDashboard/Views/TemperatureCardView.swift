//
//  TemperatureCardView.swift
//  firstProject
//
//  Created by Jordan Kramer on 6/7/24.
//
import SwiftUI
import Foundation

struct TemperatureCardView: View {
    let temperaturesAtNoon: [Int]
    let dates: [Date]
    
    var body: some View {
        VStack(spacing: 10) {
            Text("7 Day Forecast")
                .font(.title)
                .fontWeight(.bold)
            
            ForEach(0..<min(temperaturesAtNoon.count, 7), id: \.self) { index in
                TemperatureRowView(temperature: temperaturesAtNoon[index], date: dates[index])
            }
        }
        .frame(width: 350, height: 310)
        .padding()
        .background(Color.white.opacity(0.4))
        .cornerRadius(20)
    }
}
