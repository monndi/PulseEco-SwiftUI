//
//  CityListVM.swift
//  PulseEcoSwiftUI
//
//  Created by Monika Dimitrova on 6/17/20.
//  Copyright © 2020 Monika Dimitrova. All rights reserved.
//

import Foundation
import SwiftUI

class CityListVM: ObservableObject {
    var cityList: [CityRowVM]
    var selectedMeasure: String
    let countries = [
           "Macedonia",
           "Switzerland"
    ]
    init(selectedMeasure: String) {
        self.selectedMeasure = selectedMeasure
        cityList = [CityRowVM(cityName: "Skopje",
                              countryCode: "MK",
                              countryName: "Macedonia",
                              message: "Good air quality",
                              value: selectedMeasure == "pm10" ? "3" : nil,
                              unit: selectedMeasure == "pm10" ? "µq/m3" : "C"),
                    CityRowVM(cityName: "Bitola",
                              countryCode: "MK",
                              countryName: "Macedonia",
                              message: "Good air quality",
                              value: "3",
                              unit: "µq/m3"),
                    CityRowVM(cityName: "Cork",
                                     countryCode: "MK",
                                     countryName: "Macedonia",
                                     message: "Good air quality",
                                     value: "3",
                                     unit: "µq/m3")
        ]
    }
}

