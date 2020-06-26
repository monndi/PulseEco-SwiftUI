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
    var sensorType: String
    var title: String
    var value: String
    var unit: String
    var time: String
    var date: String
    var image: String
    
    init(sensorID: String) {
        self.sensorID = sensorID
        self.sensorType = "wifi"
        self.title = "Karposh3"
        self.value = "10"
        self.unit = "µq/m3"
        self.date = "08.06.2020"
        self.time = "14:10"
        self.image = "wifiTypeIcon"
    }
}
