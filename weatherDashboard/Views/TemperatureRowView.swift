//
//  TemperatureRowView.swift
//  firstProject
//
//  Created by Jordan Kramer on 6/7/24.
//

import Foundation
import SwiftUI

struct TemperatureRowView: View {
    let temperature: Int
    let date: Date
    
    var body: some View {
        HStack {
            WeatherIconView()
            Text("\(temperature)°F")
                .font(.title)
                .fontWeight(.bold)
            Spacer()
            Text("\(formattedDate())")
                .font(.subheadline)
        }
    }
    
    func formattedDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM d, yyyy"
        return dateFormatter.string(from: date)
    }
}
