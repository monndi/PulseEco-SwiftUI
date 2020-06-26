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
    
    init(selectedMeasure: String) {
        self.selectedMeasure = selectedMeasure
        cityList = [CityRowVM(cityName: "Skopje",
                              countryCode: "MK",
                              countryName: "Macedonia",
                              message: "Good air quality",
                              value: selectedMeasure == "PM10" ? "3" : nil,
                              unit: selectedMeasure == "PM10" ? "µq/m3" : "C"),
                    CityRowVM(cityName: "Bitola",
                              countryCode: "MK",
                              countryName: "Macedonia",
                              message: "Good air quality",
                              value: "3",
                              unit: "µq/m3")]
    }
}

class CityRowVM: ObservableObject, Identifiable {
    var id: String { return cityName }
    var cityName: String
    var countryCode: String
    var countryName: String
    var message: String
    var value: String?
    var color: Color { return value == nil ? Color(AppColors.gray) : Color(AppColors.green)}
    var unit: String
    var noReadings: Bool {
        return value == nil
    }

    init(cityName: String, countryCode: String, countryName: String, message: String, value: String?, unit: String) {
        self.cityName = cityName
        self.countryCode = countryCode
        self.countryName = countryName
        self.message = message
        self.value = value
        self.unit = unit
    }
}
