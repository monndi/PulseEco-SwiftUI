//
//  CityMapVM.swift
//  PulseEcoSwiftUI
//
//  Created by Monika Dimitrova on 6/17/20.
//  Copyright © 2020 Monika Dimitrova. All rights reserved.
//

import Foundation

class CityMapVM: ObservableObject {
    @Published var city: CityModel
    @Published var showSensorDetails: Bool
    @Published var sensorClicked: SensorVM?
    
    init(city: CityModel) {
        self.city = city
        self.showSensorDetails = false
        self.sensorClicked = nil
    }
}
