//
//  WeatherIconView.swift
//  firstProject
//
//  Created by Jordan Kramer on 6/7/24.
//

import SwiftUI

struct WeatherIconView: View {
    enum WeatherImageType {
        case sun
        case rain
    }
    
    var imageType: WeatherImageType?
    
    var body: some View {
        let systemName: String
        let color: Color
        
        switch imageType {
        case .rain:
            systemName = "cloud.rain.fill"
            color = .white
        default:
            systemName = "sun.max.fill"
            color = .yellow
        }
        
        return Image(systemName: systemName)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 30, height: 30)
            .foregroundColor(color)
    }
}

