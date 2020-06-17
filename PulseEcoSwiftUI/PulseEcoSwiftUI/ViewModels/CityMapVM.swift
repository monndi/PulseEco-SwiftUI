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
    @Published var showDetails: Bool
    @Published var sensorClicked: Pin?
    
    init(city: CityModel) {
        self.city = city
        self.showDetails = false
        self.sensorClicked = nil
    }
}
