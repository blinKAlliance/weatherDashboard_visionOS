//
//  TimeCardView.swift
//  firstProject
//
//  Created by Jordan Kramer on 6/7/24.
//

import Foundation
import SwiftUI
import CoreLocation

struct TimeCardView: View {
    @State private var city: String = "Saint Louis"
    @State private var state: String = "Missouri"
    @State private var currentTime: String = ""
    @State private var currentDate: String = ""
    
    private let dateFormatter = DateFormatter()
    
    var body: some View {
        VStack(spacing: 10) {
            Text("\(city), \(state)")
                .font(.title2)
            
            Text("\(currentTime)")
                .font(.system(size: 40))
                .fontWeight(.bold)
            
            Text("\(currentDate)")
                .font(.callout)
        }
        .frame(width: 350, height: 310)
        .padding()
        .background(Color.white.opacity(0.4))
        .cornerRadius(20)
        .onAppear {
            updateTimeAndDate()
        }
    }
    
    private func updateTimeAndDate() {
        dateFormatter.dateFormat = "h:mm a"
        currentTime = dateFormatter.string(from: Date())
        
        dateFormatter.dateFormat = "EEEE, MMM d"
        currentDate = dateFormatter.string(from: Date())
    }
}
