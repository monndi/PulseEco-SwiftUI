//
//  Sensor.swift
//  PulseEcoSwiftUI
//
//  Created by Monika Dimitrova on 6/10/20.
//  Copyright © 2020 Monika Dimitrova. All rights reserved.
//

import Foundation
import MapKit
// MARK: - SensorModel

struct SensorModel: Codable {
    var id: String { return sensorID }
    let sensorID, position, comments, type: String
    let description, status: String

    enum CodingKeys: String, CodingKey {
        case sensorID = "sensorId"
        case position, comments, type
        case description
        case status
    }
}

typealias SensorsResult = [SensorModel]
