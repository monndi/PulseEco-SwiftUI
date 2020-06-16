//
//  CityOverallValues.swift
//  PulseEcoSwiftUI
//
//  Created by Monika Dimitrova on 6/10/20.
//  Copyright © 2020 Monika Dimitrova. All rights reserved.
//

import Foundation

// MARK: - CityOverallValues
struct CityOverallValues: Codable {
    let cityName: String
    let values: Values
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
    init(){
        no2 = ""
         pm25 = ""
         o3 = ""
         pm10 = ""
         temperature = ""
         humidity = ""
         pressure = ""
         noiseDBA = ""
        
    }
}
