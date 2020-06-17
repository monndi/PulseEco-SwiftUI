//
//  CityOverallValues.swift
//  PulseEcoSwiftUI
//
//  Created by Monika Dimitrova on 6/10/20.
//  Copyright © 2020 Monika Dimitrova. All rights reserved.
//

import Foundation

//struct CityOverallValues: Codable {
//    let cityName: String
//    let values: Values
//    init(cityName: String, values: Values) {
//        cityName = cityName
//        values = Values()
//    }
//}

// MARK: - CityOverallValues
struct CityOverallValues: Codable {
    let cityName: String
    let values: Values
    init(cityName: String, values: Values) {
        self.cityName = cityName
        self.values = values
    }
    init() {
            cityName = ""
            values = Values()
        }
}

// MARK: - Values
struct Values: Codable {
    let no2, pm25, o3, pm10: String
    let temperature, humidity, pressure, noiseDBA: String

    enum CodingKeys: String, CodingKey {
        case no2, pm25, o3, pm10, temperature, humidity, pressure
        case noiseDBA = "noise_dba"
    }
    init(no2: String, pm25: String, o3: String, pm10: String, temperature: String, humidity: String, pressure: String, noiseDBA: String){
        self.no2 = no2
         self.pm25 = pm25
         self.o3 = o3
         self.pm10 = pm10
         self.temperature = temperature
         self.humidity = humidity
         self.pressure = pressure
         self.noiseDBA = noiseDBA
        
    }
    init() {
         self.no2 = ""
                self.pm25 = ""
                self.o3 = ""
                self.pm10 = ""
                self.temperature = ""
                self.humidity = ""
                self.pressure = ""
                self.noiseDBA = ""
    }
}
