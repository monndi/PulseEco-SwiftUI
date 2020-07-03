//
//  SensorData.swift
//  PulseEcoSwiftUI
//
//  Created by Monika Dimitrova on 6/11/20.
//  Copyright © 2020 Monika Dimitrova. All rights reserved.
//

import Foundation

class SensorData: Codable, ObservableObject {
    var id: String { return sensorId! }
    let sensorId: String?     // The unique ID of the sensor.
    let position: String?     // "Latidide longitute" GPS coordinates
    let stamp: String?        // Timestamp when the measurement was taken
    let year: Int?            // (optional) year where the measurement was taken.
    let type: String?         // The type of the value taken
    let value: String?         // The actual value
    
    init() {
        sensorId = "The unique ID of the sensor."
        position = "Latidide longitute GPS coordinates"
        stamp = "Timestamp when the measurement was taken"
        year = nil
        type = "The type of the value taken"
        value = "Value"
    }
}

typealias SensorResults = [SensorData]
