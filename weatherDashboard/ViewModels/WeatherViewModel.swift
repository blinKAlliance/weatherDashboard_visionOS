//
//  WeatherViewModel.swift
//  firstProject
//
//  Created by Jordan Kramer on 6/7/24.
//

import Foundation
import Combine

class WeatherViewModel: ObservableObject {
    @Published var temperaturesAtNoon: [Int] = []
    @Published var fiveHourForecast: [(time: String, temperature: Int, precipitationProbability: Int)] = []
    @Published var dates: [Date] = [
        Date().addingTimeInterval(86400 * 0),
        Date().addingTimeInterval(86400 * 1),
        Date().addingTimeInterval(86400 * 2),
        Date().addingTimeInterval(86400 * 3),
        Date().addingTimeInterval(86400 * 4),
        Date().addingTimeInterval(86400 * 5),
        Date().addingTimeInterval(86400 * 6)
    ]
    private var cancellables = Set<AnyCancellable>()
    
    func fetchWeather() {
        guard let url = URL(string: "https://api.open-meteo.com/v1/gfs?latitude=52.52&longitude=13.41&hourly=temperature_2m,precipitation_probability&temperature_unit=fahrenheit&wind_speed_unit=mph&timezone=America%2FChicago") else {
            print("Invalid URL")
            return
        }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: WeatherResponse.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("Error fetching weather: \(error)")
                }
            }, receiveValue: { [weak self] response in
                self?.processWeatherData(response)
            })
            .store(in: &cancellables)
    }
    
    private func processWeatherData(_ response: WeatherResponse) {
            var noonTemperatures: [Int] = []
            var forecast: [(String, Int, Int)] = []
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm"
            let calendar = Calendar.current
            let timeZone = TimeZone(identifier: "America/Chicago")!

            // Get today's date in the specified timezone
            let today = Date()
            var components = calendar.dateComponents(in: timeZone, from: today)
            components.hour = 12
            components.minute = 0
            components.second = 0

            // Iterate through the next 7 days to find noon temperatures
            for dayOffset in 0..<7 {
                if let targetNoon = calendar.date(byAdding: .day, value: dayOffset, to: calendar.date(from: components)!) {
                    // Find the index of the closest time to noon on that day
                    if let index = response.hourly.time.firstIndex(where: { timeString in
                        if let date = dateFormatter.date(from: timeString) {
                            return calendar.isDate(date, equalTo: targetNoon, toGranularity: .hour)
                        }
                        return false
                    }) {
                        // Round the temperature and add it to the array
                        let roundedTemperature = Int(round(response.hourly.temperature_2m[index]))
                        noonTemperatures.append(roundedTemperature)
                    } else {
                        print("No noon temperature found for \(targetNoon)") // Debug statement
                    }
                }
            }

            // Extract the next 5 hours of forecast data
            // Assume response.hourly.time and response.hourly.temperature_2m are available
            let currentHour = calendar.component(.hour, from: Date())
            guard let startIndex = response.hourly.time.firstIndex(where: { timeString in
                if let date = dateFormatter.date(from: timeString) {
                    let hour = calendar.component(.hour, from: date)
                    return hour >= currentHour
                }
                return false
            }) else {
                print("Current hour not found in forecast")
                return
            }
            
            for index in startIndex..<min(startIndex + 5, response.hourly.time.count) {
                let timeString = response.hourly.time[index]
                let temperature = Int(round(response.hourly.temperature_2m[index]))
                let precipitationProbability = response.hourly.precipitation_probability[index]
                forecast.append((timeString, temperature, precipitationProbability))
            }

            // Update the published properties
            self.temperaturesAtNoon = noonTemperatures
            self.fiveHourForecast = forecast
        print(self.fiveHourForecast)
        }
}
