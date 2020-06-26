//
//  AverageVM.swift
//  PulseEcoSwiftUI
//
//  Created by Monika Dimitrova on 6/17/20.
//  Copyright © 2020 Monika Dimitrova. All rights reserved.
//

import Foundation
import SwiftUI

class AverageVM: ObservableObject {
    var value: String?
    var unit: String
    var message: String
    var measure: String
    var cityName: String
    var clickDisabled: Bool { return value == nil }
    
    init(measure: String, cityName: String) {
        self.value = measure == "PM10" ? "5" : nil
        self.message = "Good air quality. Air quality is considered satisfactory, and air pollution poses little or no risk."
        self.measure = measure
        self.unit = measure == "PM10" ? "µq/m3" : "C"
        self.cityName = cityName
    }
}
