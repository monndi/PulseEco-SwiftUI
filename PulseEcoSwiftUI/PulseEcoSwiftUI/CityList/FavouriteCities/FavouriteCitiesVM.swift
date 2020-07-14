//
//  CityListVM.swift
//  PulseEcoSwiftUI
//
//  Created by Monika Dimitrova on 6/17/20.
//  Copyright © 2020 Monika Dimitrova. All rights reserved.
//

import Foundation
import SwiftUI

class FavouriteCitiesVM: ObservableObject {
    @Published var cityList: [FavouriteCityRowVM] = []
    var selectedMeasure: String

    init(selectedMeasure: String, favouriteCities: Set<CityModel>) {
        self.selectedMeasure = selectedMeasure
        for city in favouriteCities {
            self.cityList.append(FavouriteCityRowVM(cityName: city.cityName, siteName: city.siteName, countryCode: city.countryCode, countryName: city.countryName, message: "No message!", value: selectedMeasure == "pm10" ? "3" : nil, unit: selectedMeasure == "pm10" ? "µq/m3" : "C"))
        }
//        cityList = [FavouriteCityRowVM(cityName: "Skopje",
//                              countryCode: "MK",
//                              countryName: "Macedonia",
//                              message: "Good air quality",
//                              value: selectedMeasure == "pm10" ? "3" : nil,
//                              unit: selectedMeasure == "pm10" ? "µq/m3" : "C"),
//                    FavouriteCityRowVM(cityName: "Bitola",
//                              countryCode: "MK",
//                              countryName: "Macedonia",
//                              message: "Good air quality",
//                              value: "3",
//                              unit: "µq/m3"),
//                    FavouriteCityRowVM(cityName: "Cork",
//                                     countryCode: "MK",
//                                     countryName: "Macedonia",
//                                     message: "Good air quality",
//                                     value: "3",
//                                     unit: "µq/m3")
//        ]
    }
    
    func getCities() -> [FavouriteCityRowVM] {
        return self.cityList.sorted { $0.siteName < $1.siteName}
    }
}

