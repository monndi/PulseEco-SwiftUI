//
//  SensorDetailsVM.swift
//  PulseEcoSwiftUI
//
//  Created by Monika Dimitrova on 6/19/20.
//  Copyright © 2020 Monika Dimitrova. All rights reserved.
//

import Foundation
import SwiftUI

class SensorDetailsVM {
    var sensorID: String
    var sensorType: SensorType
    var title: String
    var value: String
    var unit: String
    var time: String
    var date: String
    var image: UIImage
    init(sensor: SensorVM, sensorsData: [Sensor], selectedMeasure: Measure) {
        self.sensorID = sensor.sensorID
        self.sensorType = sensor.type
        self.title = sensor.title ?? "Sensor"
        self.value = sensor.value
        self.unit = selectedMeasure.unit
        self.date = "20-02-2020"
        self.time = "16:41"
        self.image = sensorType.imageForType ?? UIImage()
    }
}
