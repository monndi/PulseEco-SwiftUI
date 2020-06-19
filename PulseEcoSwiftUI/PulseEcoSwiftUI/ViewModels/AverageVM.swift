//
//  AverageVM.swift
//  PulseEcoSwiftUI
//
//  Created by Monika Dimitrova on 6/17/20.
//  Copyright © 2020 Monika Dimitrova. All rights reserved.
//

import Foundation

class AverageVM: ObservableObject {
    var value: String
    var unit: String
    var message: String
    
    init() {
        self.value = "5"
        self.unit = "mq/m3"
        self.message = "Good air quality. Air quality is considered satisfactory, and air pollution poses little or no risk."
    }
}
